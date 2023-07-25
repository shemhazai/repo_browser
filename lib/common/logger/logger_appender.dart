abstract class LoggerAppender {
  void append(String message);

  void appendError(Object error, [StackTrace? stackTrace]);
}
