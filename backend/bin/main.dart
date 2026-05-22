// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:dotenv/dotenv.dart';

const List<String> availableSoundIds = [
  // Nature
  'woodpecker', 'frog', 'strok', 'city_park', 'fireplace', 'bonfire', 'bird', 'thunder', 'cricket', 'forest', 'wind', 'jungle',
  // Water
  'River', 'Small creek', 'Rain', 'Rain on car roof', 'Rain on car windows', 'Fountain in park', 'Rain under raincoat', 'Rain on windows', 'Sea', 'Cave', 'Waterfall', 'Jacuzzi',
  // Music
  'Meditation', 'Healing meditation', 'Yoga', 'Asian piano', 'Piano', 'Background Piano ', 'Binaural', 'Guitar Song', 'Background Guitar', 'Om surrounding', 'Zen', 'Flute',
  // Mechanical
  'Plane', 'Train', 'Car Driving', 'Bus', 'Washing machine', 'Air Conditioner', 'Vacuum cleaner', 'Hair dryer', 'Keyboard'
];

const List<String> musicSoundIds = [
  'Meditation', 'Healing meditation', 'Yoga', 'Asian piano', 'Piano', 'Background Piano ', 'Binaural', 'Guitar Song', 'Background Guitar', 'Om surrounding', 'Zen', 'Flute'
];

void main() async {
  // Load environment variables from .env
  final env = DotEnv(includePlatformEnvironment: true)..load();

  // Support both DEEPSEEK_API_KEY and GEMINI_API_KEY (in case the API key is set in GEMINI_API_KEY slot)
  final apiKey = Platform.environment['DEEPSEEK_API_KEY'] ??
      env['DEEPSEEK_API_KEY'] ??
      Platform.environment['GEMINI_API_KEY'] ??
      env['GEMINI_API_KEY'];

  if (apiKey == null || apiKey.isEmpty || apiKey == 'YOUR_GEMINI_API_KEY_HERE' || apiKey == 'YOUR_DEEPSEEK_API_KEY_HERE') {
    print('WARNING: DEEPSEEK_API_KEY (or GEMINI_API_KEY) is not set in environment or .env file.');
  }

  // Set up Shelf server Router
  final router = Router();

  // POST endpoint to handle client request
  router.post('/generateSleepSession', (Request request) async {
    try {
      final body = await request.readAsString();
      final Map<String, dynamic> jsonBody = jsonDecode(body);
      final mood = jsonBody['mood'] as String? ?? 'spokojny sen';

      if (apiKey == null || apiKey.isEmpty || apiKey == 'YOUR_GEMINI_API_KEY_HERE' || apiKey == 'YOUR_DEEPSEEK_API_KEY_HERE') {
        throw Exception('API Key is missing. Please set DEEPSEEK_API_KEY in your backend/.env file.');
      }

      final systemInstruction = '''
You are a peaceful sleep, mindfulness, and relaxation coach.
Your goal is to analyze the user's current sleep/relaxation need (e.g., stress, difficulty sleeping, concentration, putting a baby to sleep) and:
1. Write a highly comforting, short, empathetic advice or a quick mindfulness/breathing micro-exercise in Polish (max 80-100 words).
2. Design a custom soundscape mix selecting 1 to 4 matching sound IDs from the available sound IDs list below, assigning a volume level of exactly 0.5 (representing 50%) to each selected sound to create a balanced ambient background.

Instructions for advice:
- The advice must be in Polish.
- It must be warm, reassuring, and practical (e.g. "Oddychaj spokojnie...", "Wyobraź sobie...", "Rozluźnij ramiona...").
- Keep it concise, soothing, and easy to read (max 80-100 words).

Instructions for sounds & volumes:
- Select 1 to 4 matching sounds from the list of available sound IDs below.
- Choose ONLY from: ${availableSoundIds.join(', ')}.
- Assign exactly 0.5 as the volume for each selected sound.
- IMPORTANT RULE FOR MUSIC SOUNDS: Do NOT select more than ONE sound from the Music category. Selecting multiple music sounds at the same time (e.g., combining Zen and Piano) creates chaotic noise. You can mix one music sound with nature or water sounds, but never mix multiple music tracks together.

Format your final output strictly as a JSON object with two keys:
1. "advice": (string) containing the personalized comfort advice or quick micro-exercise in Polish.
2. "recommendedSounds": (array of objects) where each object represents a recommended sound and has two keys:
   - "id": (string) chosen ONLY from the list of available sound IDs below.
   - "volume": (double) exactly 0.5.

Available sound IDs:
${availableSoundIds.join(', ')}
''';

      final userPrompt = 'Create a custom sleep coach recommendations mix based on user mood/setting request: "$mood"';

      String? responseText;
      int retries = 3;
      dynamic lastError;

      while (retries > 0) {
        try {
          final response = await http.post(
            Uri.parse('https://api.deepseek.com/chat/completions'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $apiKey',
            },
            body: jsonEncode({
              'model': 'deepseek-chat',
              'messages': [
                {'role': 'system', 'content': systemInstruction},
                {'role': 'user', 'content': userPrompt},
              ],
              'response_format': {'type': 'json_object'},
              'stream': false,
            }),
          ).timeout(const Duration(seconds: 15));

          if (response.statusCode == 200) {
            final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
            final choices = decodedResponse['choices'] as List<dynamic>?;
            if (choices != null && choices.isNotEmpty) {
              final message = choices[0]['message'] as Map<String, dynamic>?;
              if (message != null) {
                responseText = message['content'] as String?;
                if (responseText != null && responseText.trim().isNotEmpty) {
                  break; // Success!
                }
              }
            }
            throw Exception('Invalid response structure from DeepSeek API: ${response.body}');
          } else {
            throw Exception('DeepSeek API returned status ${response.statusCode}: ${response.body}');
          }
        } catch (e) {
          retries--;
          lastError = e;
          if (retries > 0) {
            print('DeepSeek API failed ($e). Retrying in 1.5 seconds... ($retries retries left)');
            await Future.delayed(const Duration(milliseconds: 1500));
          }
        }
      }

      if (responseText == null) {
        throw lastError ?? Exception('Failed to generate content from DeepSeek after retries.');
      }

      final Map<String, dynamic> decoded = jsonDecode(responseText);
      
      // Parse with fallback validation
      final advice = decoded['advice'] as String? ?? decoded['story'] as String? ?? 'Oddychaj spokojnie i pozwól sobie na odpoczynek...';
      final rawSounds = decoded['recommendedSounds'] as List<dynamic>? ?? [];
      
      final List<Map<String, dynamic>> recommendedSounds = [];
      bool hasAddedMusic = false;

      for (final item in rawSounds) {
        if (item is Map) {
          final id = item['id']?.toString() ?? '';
          // Try to match the case-insensitive or exact ID from our available list
          final matchingId = availableSoundIds.firstWhere(
            (availableId) => availableId.toLowerCase() == id.toLowerCase(),
            orElse: () => '',
          );
          
          if (matchingId.isNotEmpty) {
            final isMusic = musicSoundIds.any(
              (musicId) => musicId.toLowerCase() == matchingId.toLowerCase()
            );
            if (isMusic) {
              if (hasAddedMusic) {
                // Skip subsequent music tracks to avoid mixing them
                continue;
              }
              hasAddedMusic = true;
            }
            recommendedSounds.add({
              'id': matchingId,
              'volume': 0.5, // Always set to 50% (0.5) as requested
            });
          }
        } else if (item is String) {
          // Fallback if model returned just string IDs instead of objects
          final matchingId = availableSoundIds.firstWhere(
            (availableId) => availableId.toLowerCase() == item.toLowerCase(),
            orElse: () => '',
          );
          if (matchingId.isNotEmpty) {
            final isMusic = musicSoundIds.any(
              (musicId) => musicId.toLowerCase() == matchingId.toLowerCase()
            );
            if (isMusic) {
              if (hasAddedMusic) {
                continue;
              }
              hasAddedMusic = true;
            }
            recommendedSounds.add({
              'id': matchingId,
              'volume': 0.5, // Always set to 50% (0.5) as requested
            });
          }
        }
      }

      return Response.ok(
        jsonEncode({
          'advice': advice,
          'recommendedSounds': recommendedSounds,
        }),
        headers: {'Content-Type': 'application/json'},
      );
    } catch (e) {
      print('Error generating sleep session: $e');
      return Response.internalServerError(
        body: jsonEncode({'error': e.toString()}),
        headers: {'Content-Type': 'application/json'},
      );
    }
  });

  // Enable CORS
  final handler = const Pipeline()
      .addMiddleware((innerHandler) {
        return (request) async {
          if (request.method == 'OPTIONS') {
            return Response.ok('', headers: {
              'Access-Control-Allow-Origin': '*',
              'Access-Control-Allow-Methods': 'POST, GET, OPTIONS',
              'Access-Control-Allow-Headers': 'Origin, Content-Type, X-Auth-Token',
            });
          }
          final response = await innerHandler(request);
          return response.change(headers: {
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'POST, GET, OPTIONS',
            'Access-Control-Allow-Headers': 'Origin, Content-Type, X-Auth-Token',
          });
        };
      })
      .addHandler(router.call);

  // Start the server
  final server = await io.serve(handler, '0.0.0.0', 3400);
  print('Good Dream AI Backend running on port ${server.port}');
}
