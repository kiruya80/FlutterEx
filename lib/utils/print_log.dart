import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

enum LOG_LEVEL {
  DEBUG,
  INFO,
  WARNING,
  ERROR,
}

var logger = Logger(
  printer: PrettyPrinter(
      methodCount: 4,
      // number of method calls to be displayed
      errorMethodCount: 8,
      // number of method calls if stacktrace is provided
      lineLength: 120,
      // width of the output
      colors: true,
      // Colorful log messages
      printEmojis: false,
      // Print an emoji for each log message
      printTime: true // Should each log print contain a timestamp
      ),
);

class Print {
  static DateFormat? dateFormat;

  // kDebugMode
  // bool isShowLog = true;
  bool isShowLog = kDebugMode;

  // static const String _APP_TAG = '_MC_'; // middle client

  static String getTime() {
    if (dateFormat == null) dateFormat = DateFormat('HH:mm:ss.sss');

    return dateFormat!.format(DateTime.now());
  }

  static d(msg) {
    logger.d(msg);
  }

  static i(msg) {
    logger.i(msg);
  }

  static w(msg) {
    logger.w(msg);
  }

  static e(msg) {
    logger.e(msg);
  }

  static void LogPrint(Object object) async {
    int defaultPrintLength = 1020;
    if (object == null || object.toString().length <= defaultPrintLength) {
      print(object);
    } else {
      String log = object.toString();
      int start = 0;
      int endIndex = defaultPrintLength;
      int logLength = log.length;
      int tmpLogLength = log.length;
      while (endIndex < logLength) {
        print(log.substring(start, endIndex));
        endIndex += defaultPrintLength;
        start += defaultPrintLength;
        tmpLogLength -= defaultPrintLength;
      }
      if (tmpLogLength > 0) {
        print(log.substring(start, logLength));
      }
    }
  }
}
