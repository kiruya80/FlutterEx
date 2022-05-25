import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutterex/network/app_exception.dart';
import 'package:flutterex/network/http_interceptor.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/http.dart';

class QcHttpClient {
  // sample : https://jsonplaceholder.typicode.com/
  static const API_BASE_DOMAIN = "jsonplaceholder.typicode.com";
  static const API_DOMAIN = "jsonplaceholder.typicode.com";

  static final QcHttpClient instance = QcHttpClient.init();

  factory QcHttpClient() {
    return instance;
  }

  QcHttpClient.init() {
    QcLog.d("QcHttpClient Init");
  }

  Map<String, String> header = {};

  void addHeader(key, value) {
    header[key] = value;
  }

  final http = InterceptedHttp.build(interceptors: [HttpLoggerInterceptor()]);

  /**
   * 운영 검증 버전 도메인 구분
   */
  String getDomain() {
    return kDebugMode ? API_BASE_DOMAIN : API_DOMAIN;
  }

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParams = const {},
    // Map<String, dynamic>? params,
  }) async {
    QcLog.i(" WHAT>>> : $path");
    dynamic responseJson;
    try {
      // final uri = Uri.https(getDomain(), path, queryParams);
      final uri = Uri.https(getDomain(), path);
      QcLog.i("request uri >>> : " + uri.toString());
      final response = await http
          .get(uri, headers: header, params: queryParams)
          .timeout(const Duration(seconds: 10));
      responseJson = _returnResponse(response);
    } on Exception catch (e) {
      throw exceptionTypeCheck(e);
    }
    return responseJson;
  }

  Future<dynamic> post(
    String path, {
    // dynamic queryParams = const {},
    dynamic queryParams,
    Object? body,
    Encoding? encoding,
  }) async {
    dynamic responseJson;
    try {
      final uri = Uri.https(getDomain(), path, queryParams);
      final response = await http
          .post(uri, headers: header, body: body, encoding: encoding)
          .timeout(const Duration(seconds: 10));
      responseJson = _returnResponse(response);
    } on Exception catch (e) {
      throw exceptionTypeCheck(e);
    }
    return responseJson;
  }

  Future<dynamic> put(
    String path, {
    dynamic queryParams = const {},
    dynamic body = const {},
    Encoding? encoding,
  }) async {
    dynamic responseJson;
    try {
      final uri = Uri.https(getDomain(), path, queryParams);
      final response = await http
          .put(uri, headers: header, body: body, encoding: encoding)
          .timeout(const Duration(seconds: 10));
      responseJson = _returnResponse(response);
    } on Exception catch (e) {
      throw exceptionTypeCheck(e);
    }
    return responseJson;
  }

  Future<dynamic> patch(
    String path, {
    dynamic queryParams = const {},
    dynamic body = const {},
    Encoding? encoding,
  }) async {
    dynamic responseJson;
    try {
      final uri = Uri.https(getDomain(), path, queryParams);
      final response = await http
          .patch(uri, headers: header, body: body, encoding: encoding)
          .timeout(const Duration(seconds: 10));
      responseJson = _returnResponse(response);
    } on Exception catch (e) {
      throw exceptionTypeCheck(e);
    }

    return responseJson;
  }

  Future<dynamic> delete(
    String path, {
    Object? body,
    Encoding? encoding,
  }) async {
    dynamic responseJson;
    try {
      final response = await http
          .delete(Uri.parse(getDomain() + path),
              headers: header, body: body, encoding: encoding)
          .timeout(const Duration(seconds: 10));
      responseJson = _returnResponse(response);
    } on Exception catch (e) {
      throw exceptionTypeCheck(e);
    }
    return responseJson;
  }

  AppException exceptionTypeCheck(Exception e) {
    if (e is AppException) {
      throw e;
    } else if (e is TimeoutException) {
      throw TimeOutException(
          "일시적인 네트워크 오류로 정보를 받아오지 못했습니다.\n잠시후 다시 시도해주세요.", "Fetch TimeOut");
    } else if (e is SocketException) {
      throw TimeOutException(
          "일시적인 네트워크 오류로 정보를 받아오지 못했습니다.\n잠시후 다시 시도해주세요.", "SocketException");
    } else if (e is FormatException) {
      throw TimeOutException(
          "Bad response format.\n잠시후 다시 시도해주세요.", "FormatException");
    } else if (e is WebSocketException) {
      throw TimeOutException("일시적인 네트워크 오류로 정보를 받아오지 못했습니다.\n잠시후 다시 시도해주세요.",
          "WebSocketException");
    } else {
      throw AppException(e.toString(), "오류", "UndefinedException");
    }
  }

  dynamic _returnResponse(Response response) {
    QcLog.i(" RESPONSE responseJson >>> : ");
    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = json.decode(response.body.toString());
        if (kDebugMode) prettyPrintJson(response.body.toString());
        // var responseStatus = responseJson['RESP_RESULT']['RESP_STATUS'] ?? 200;
        // if (responseStatus is String) {
        //   responseStatus = int.parse(responseStatus);
        // }
        // if (responseStatus > 299) {
        //   return _returnSuccessException(
        //       responseJson['RESP_RESULT']['RESP_STATUS'],
        //       responseJson['RESP_RESULT']['MESSAGE'],
        //       responseJson['RESP_RESULT']['SERVICE_MSG']);
        // }
        return responseJson;
      case 401:
      case 403:
        throw AuthFailException(response.body.toString(), "Auth");
      case 500:
      case 502:
      // throw PMException(response.body.toString(), "CheckPM");
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}',
            "Server Error");
    }
  }

  void prettyPrintJson(String input) {
    QcLog.e('prettyPrintJson ============================= ');
    QcLog.w(input);
    String result = '';
    const JsonDecoder decoder = JsonDecoder();
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final dynamic object = decoder.convert(input);
    final dynamic prettyString = encoder.convert(object);
    prettyString.split('\n').forEach((dynamic element) {
      result += element + '\n';
      print(element);
    });
    QcLog.e('result ============================= ');
    QcLog.w(result);
  }

  dynamic _returnSuccessException(
      int appStateCode, String message, String serviceMessage) {
    switch (appStateCode) {
      case 401:
      case 403:
        throw AuthFailException(message, serviceMessage);
      case 500:
      case 502:
      // throw PMException(message, serviceMessage);
      default:
        throw SuccessException(message, serviceMessage);
    }
  }
}
