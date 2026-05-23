import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;

class AIAssistantService {
  String get baseUrl {
    // In release mode (production builds for testers), connect to the cloud server.
    // Replace the URL below with your actual URL when you deploy the backend on Render/Railway.
    if (kReleaseMode) {
      return 'https://good-dream-backend.onrender.com'; 
    }

    if (kIsWeb) {
      return 'http://localhost:3400';
    }
    try {
      if (Platform.isAndroid) {
        // For physical device testing, use the host machine's local IP.
        return 'http://192.168.100.167:3400';
      }
    } catch (_) {
      // Fallback for platform exceptions if Platform is not supported on Web
    }
    return 'http://localhost:3400';
  }

  /// Sends a request to the backend Gemini AI flow to get sleep advice
  /// and obtain recommended matching catalog sound IDs with custom volume levels.
  Future<Map<String, dynamic>> generateSleepSession(String mood, {List<String>? rejectedSounds}) async {
    final url = Uri.parse('$baseUrl/generateSleepSession');
    try {
      final bodyData = <String, dynamic>{'mood': mood};
      if (rejectedSounds != null && rejectedSounds.isNotEmpty) {
        bodyData['rejectedSounds'] = rejectedSounds;
      }

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(bodyData),
      ).timeout(const Duration(seconds: 45));

      if (response.statusCode == 200) {
        final Map<String, dynamic> decoded = jsonDecode(response.body);
        return {
          'success': true,
          'recommendedSounds': decoded['recommendedSounds'] as List<dynamic>? ?? [],
          'proposedNames': decoded['proposedNames'] as List<dynamic>? ?? [],
        };
      } else {
        String errorMsg = 'Wystąpił nieznany błąd serwera.';
        try {
          final Map<String, dynamic> errorBody = jsonDecode(response.body);
          errorMsg = errorBody['error'] ?? errorMsg;
        } catch (_) {}
        return {
          'success': false,
          'error': 'Błąd serwera (${response.statusCode}): $errorMsg',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Nie można połączyć się z lokalnym serwerem AI. Upewnij się, że serwer w katalogu "backend/" jest uruchomiony na porcie 3400.\nSzczegóły: $e',
      };
    }
  }
}
