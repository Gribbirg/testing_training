import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:testing_training/services/error_handler/abstract_error_handler.dart';

class FirebaseErrorHandler extends AbstractErrorHandler {
  @override
  Future<void> handleError(
      {required dynamic exception,
      StackTrace? stack,
      bool isFatal = false}) async {
    debugPrint(
        'Error:\n${exception.toString()}\nStack:\n${stack?.toString() ?? 'null'}\nfatal: $isFatal');
    if (!kIsWeb) {
      FirebaseCrashlytics.instance
          .recordError(exception, stack, fatal: isFatal);
    }
  }
}
