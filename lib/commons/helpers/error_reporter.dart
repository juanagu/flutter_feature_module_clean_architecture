abstract class ErrorReporter {
  void report(String tag, Exception error);

  void reportWithMessage(String tag, String message);
}
