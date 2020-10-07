import 'package:app/commons/helpers/logger.dart';
import 'package:logger/logger.dart' as flutter_logger;

class FlutterLoggerImpl implements Logger {
  final flutter_logger.Logger flutterLogger;

  FlutterLoggerImpl()
      : flutterLogger = flutter_logger.Logger(
          filter: null,
          printer: flutter_logger.PrettyPrinter(),
          output: null,
        );

  @override
  void debug(String message) {
    flutterLogger.d(message);
  }

  @override
  void error(String message) {
    flutterLogger.e(message);
  }

  @override
  void info(String message) {
    flutterLogger.i(message);
  }
}
