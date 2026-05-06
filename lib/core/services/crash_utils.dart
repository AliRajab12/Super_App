import 'dart:developer';

import 'package:somi/core/widgets/crash_screen.dart';
import 'package:somi/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Utility class to handle crash reporting using Firebase Crashlytics
class CrashUtils {
  late FirebaseCrashlytics _crashlytics;

  /// Initializes CrashUtils by setting up Crashlytics and the crash screen
  Future<void> init() async {
    // Initialize Firebase with platform-specific options
    await Firebase.initializeApp(
        name: 'degreed-flutter',
        options: DefaultFirebaseOptions.currentPlatform);
    // Capture the Crashlytics instance and enable error collection
    _crashlytics = FirebaseCrashlytics.instance;
    _crashlytics.setCrashlyticsCollectionEnabled(true);

    // Set up the default error widget builder to return an instance of CrashScreen
    ErrorWidget.builder = (error) {
      if (kDebugMode) {
        FlutterError.dumpErrorToConsole(error);
      }
      return CrashScreen(error); // Display the crash screen with error details
    };
  }

  /// Handles and logs uncaught Dart errors to Crashlytics
  Future<void> collectDartError(Object exception, StackTrace? stack) async {
    // Log the error details to the console in debug mode
    if (kDebugMode) {
      log('A Dart Error Occurred!', error: exception, stackTrace: stack);
    }
    // Record the error in Firebase Crashlytics
    await FirebaseCrashlytics.instance.recordError(exception, stack);
  }

  /// Handles and logs Flutter-specific errors to Crashlytics
  Future<void> collectFlutterError(FlutterErrorDetails error) async {
    await FirebaseCrashlytics.instance.recordFlutterError(error);
  }

  /// Logs a custom message to be included in the next error report sent to Crashlytics
  Future<void> logMessage(String message) async {
    await _crashlytics.log(message);
  }
}
