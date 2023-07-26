/// Describes how a log should be appended to a log service.
/// 
/// I.e. it can send logs to crashlytics or any other service.
abstract class LoggerAppender {
  void append(String message);

  void appendError(Object error, [StackTrace? stackTrace]);
}
