abstract class AbstractLogger {
  Future<void> logEvent(String name, Map<String, dynamic> parameters);
}