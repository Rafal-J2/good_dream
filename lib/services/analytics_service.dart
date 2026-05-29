import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  static final Logger _logger = Logger();

  /// Logs a custom event to Firebase Analytics (and prints to console in debug mode)
  static Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {
    try {
      // In development mode, we log to console for clean debugging
      if (kDebugMode) {
        _logger.d('Analytics Event logged: "$name" with parameters: $parameters');
      }
      
      // Log to Firebase Analytics
      await _analytics.logEvent(
        name: name,
        parameters: parameters,
      );
    } catch (e) {
      if (kDebugMode) {
        _logger.e('Failed to log event "$name" to Firebase Analytics: $e');
      }
    }
  }

  /// Log when the tutorial starts
  static Future<void> logTutorialStarted() async {
    await logEvent(name: 'tutorial_started');
  }

  /// Log when a tutorial step is completed
  static Future<void> logTutorialStepCompleted(int step, String stepName) async {
    await logEvent(
      name: 'tutorial_step_completed',
      parameters: {
        'step_number': step,
        'step_name': stepName,
      },
    );
  }

  /// Log when the tutorial is skipped
  static Future<void> logTutorialSkipped(int atStep) async {
    await logEvent(
      name: 'tutorial_skipped',
      parameters: {
        'at_step': atStep,
      },
    );
  }

  /// Log when the tutorial is successfully finished
  static Future<void> logTutorialFinished() async {
    await logEvent(name: 'tutorial_finished');
  }

  /// Log when a mix is played (either custom favorite or ready-made)
  static Future<void> logMixPlayed(String name, bool isFavorite) async {
    await logEvent(
      name: 'mix_played',
      parameters: {
        'mix_name': name,
        'is_favorite': isFavorite ? 1 : 0,
      },
    );
  }

  /// Log when a custom mix is successfully saved to favorites
  static Future<void> logMixSaved(String name, int soundCount, String cover) async {
    await logEvent(
      name: 'mix_saved',
      parameters: {
        'mix_name': name,
        'sound_count': soundCount,
        'selected_cover': cover,
      },
    );
  }

  /// Log when the sleep timer is started
  static Future<void> logTimerStarted(int durationMinutes) async {
    await logEvent(
      name: 'timer_started',
      parameters: {
        'duration_minutes': durationMinutes,
      },
    );
  }

  /// Log when the sleep timer is cancelled manually
  static Future<void> logTimerCancelled() async {
    await logEvent(name: 'timer_cancelled');
  }
}
