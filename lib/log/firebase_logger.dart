import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:testing_training/log/abstract_logger.dart';

class FirebaseLogger extends AbstractLogger {
  @override
  Future<void> logEvent(String name, Map<String, dynamic> parameters) async {
    FirebaseAnalytics.instance.logEvent(name: name, parameters: parameters);
  }
}
