abstract class AbstractErrorHandler {
  Future<void> handleError(
      {required dynamic exception, StackTrace? stack, bool isFatal});
}
