import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:http_interceptor/http/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';
import 'package:intl/intl.dart';

class HttpLoggerInterceptor implements InterceptorContract {
  bool isShowLog = kDebugMode;
  DateFormat dateFormat = DateFormat('HH:mm:ss.sss');

  String getTime() {
    return dateFormat.format(DateTime.now());
  }

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    if (isShowLog) {
      String msg = '''
        <<<<<<<<<<<<<<  Request  >>>>>>>>>>>>>>>>>>>>>>>
        Request Url   : ${data.url}
        Request header: ${data.headers}
        Request Body  : ${data.body}
        Request time  : ${getTime()}
        --------------------------------------''';
      Print.w(msg);
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (isShowLog) {
      String msg = '''
        >>>>>>>>>>>>>>>>>> Response <<<<<<<<<<<<<<<<<<<<<<<<
        Response Url  : (${data.statusCode}) ${data.url}
        Response data : ${data.body}
        Request time  : ${getTime()}
        --------------------------------------''';

      Print.w(msg);
    }

    return data;
  }
}
