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
      methodCount: 4, // number of method calls to be displayed
      errorMethodCount: 8, // number of method calls if stacktrace is provided
      lineLength: 120, // width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      printTime: true // Should each log print contain a timestamp
  ),
);

var tinyLogger = Logger(
  printer: PrettyPrinter(
      methodCount: 0, // number of method calls to be displayed
      errorMethodCount: 8, // number of method calls if stacktrace is provided
      lineLength: 120, // width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      printTime: true // Should each log print contain a timestamp
  ),
);

class Print {
  static DateFormat? dateFormat;
  bool isShowLog = true;
  static const String _APP_TAG = '_MC_'; // middle client
  static final String _TAG = getTime() + _APP_TAG;

  static String getTime() {
    if (dateFormat == null) dateFormat = DateFormat('HH:mm:ss.sss');

    return dateFormat!.format(DateTime.now());
  }

  static v(msg) {
    logger.v(msg);
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

  static wtf(msg) {
    logger.wtf(msg);
  }

  static tiny(msg) {
    tinyLogger.d(msg);
  }

  /*
  static d(msg) {
    msg = "$_TAG:: $msg";
    // debugPrint("\x1B[34m$msg\x1B[0m", wrapWidth: 1024); // for large log
    logd(msg);
  }

  static i(msg) {
    msg = "$_TAG:: $msg";
    // debugPrint("\x1B[32m$msg\x1B[0m");
    logi(msg);
  }

  static w(msg) {
    msg = "$_TAG:: $msg";
    // debugPrint("\x1B[33m$msg\x1B[0m");
    logw(msg);
  }

  static e(msg) {
    msg = "$_TAG:: $msg";
    // debugPrint("\x1B[31m$msg\x1B[0m");
    loge(msg);
  }

  static api(msg) {
    msg = "$_TAG::$msg";
    debugPrint("\x1B[35m$msg\x1B[0m");
  }

  static api2(msg) {
    msg = "$_TAG:: $msg";
    debugPrint("\x1B[45m$msg\x1B[0m");
  }

  static dd(msg) {
    msg = "$_TAG:: $msg";
    debugPrint("\x1B[44m$msg\x1B[0m");
  }

  static ii(msg) {
    msg = "$_TAG:: $msg";
    debugPrint("\x1B[42m$msg\x1B[0m");
  }

  static ww(msg) {
    msg = "$_TAG:: $msg";
    debugPrint("\x1B[43m$msg\x1B[0m");
  }

  static ee(msg) {
    msg = "$_TAG:: $msg";
    debugPrint("\x1B[41m$msg\x1B[0m");
  }
  */

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
