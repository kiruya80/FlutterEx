import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterex/network/app_exception.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class QcDioClient {
  // sample : https://jsonplaceholder.typicode.com/
  static const API_BASE_DOMAIN = "jsonplaceholder.typicode.com";
  static const API_DOMAIN = "jsonplaceholder.typicode.com";

  static final QcDioClient instance = QcDioClient.init();
  final Dio dio = Dio();

  factory QcDioClient() {
    return instance;
  }

  QcDioClient.init() {
    QcLog.d("QcDioClient Init");
    // dio.options.baseUrl = 'https://jsonplaceholder.typicode.com';
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 3000;
    dio.options.headers = header;

    dio.interceptors.add(PrettyDioLogger());
// customization
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
  }

  Map<String, String> header = {};

  void addHeader(key, value) {
    header[key] = value;
  }

  /**
   * 운영 검증 버전 도메인 구분
   */
  String getDomain() {
    return kDebugMode ? API_BASE_DOMAIN : API_DOMAIN;
  }

  // String path, {
  // Map<String, dynamic>? queryParameters,
  //     Options? options,
  // CancelToken? cancelToken,
  //     ProgressCallback? onReceiveProgress,
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParams,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    QcLog.i(" WHAT>>> : $path");
    dynamic responseJson;
    try {
      final uri = Uri.https(getDomain(), path);
      QcLog.i("request uri >>> : " + uri.toString());
      Response response = await dio
          .get(uri.toString(), queryParameters: queryParams)
          .timeout(const Duration(seconds: 10));
      responseJson = _returnResponse(response);
    } on Exception catch (e) {
      throw exceptionTypeCheck(e);
    }
    return responseJson;
  }

  // String path, {
  // data,
  // Map<String, dynamic>? queryParameters,
  //     Options? options,
  // CancelToken? cancelToken,
  //     ProgressCallback? onSendProgress,
  // ProgressCallback? onReceiveProgress,
  Future<dynamic> post(
    String path, {
    Object? body,
    dynamic queryParams,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    QcLog.e('post ====  $body');
    dynamic responseJson;
    try {
      final uri = Uri.https(getDomain(), path, queryParams);
      final response = await dio
          .post(uri.toString(),
              data: body,
              options: options,
              cancelToken: cancelToken,
              onSendProgress: onSendProgress,
              onReceiveProgress: onReceiveProgress)
          .timeout(const Duration(seconds: 10));
      responseJson = _returnResponse(response);
    } on Exception catch (e) {
      QcLog.e('exceptionTypeCheck ====  $e');
      throw exceptionTypeCheck(e);
    }
    return responseJson;
  }

  // String path, {
  // data,
  // Map<String, dynamic>? queryParameters,
  //     Options? options,
  // CancelToken? cancelToken,
  //     ProgressCallback? onSendProgress,
  // ProgressCallback? onReceiveProgress,
  Future<dynamic> put(
    String path, {
    Object? body,
    dynamic queryParams,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    dynamic responseJson;
    try {
      final uri = Uri.https(getDomain(), path, queryParams);
      final response = await dio
          .put(uri.toString(),
              data: body,
              options: options,
              cancelToken: cancelToken,
              onSendProgress: onSendProgress,
              onReceiveProgress: onReceiveProgress)
          .timeout(const Duration(seconds: 10));
      responseJson = _returnResponse(response);
    } on Exception catch (e) {
      throw exceptionTypeCheck(e);
    }
    return responseJson;
  }

  // String path, {
  // data,
  // Map<String, dynamic>? queryParameters,
  //     Options? options,
  // CancelToken? cancelToken,
  //     ProgressCallback? onSendProgress,
  // ProgressCallback? onReceiveProgress,
  Future<dynamic> patch(
    String path, {
    Object? body,
    dynamic queryParams,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    dynamic responseJson;
    try {
      final uri = Uri.https(getDomain(), path, queryParams);
      final response = await dio
          .patch(uri.toString(),
              data: body,
              options: options,
              cancelToken: cancelToken,
              onSendProgress: onSendProgress,
              onReceiveProgress: onReceiveProgress)
          .timeout(const Duration(seconds: 10));
      responseJson = _returnResponse(response);
    } on Exception catch (e) {
      throw exceptionTypeCheck(e);
    }

    return responseJson;
  }

  // String path, {
  // data,
  // Map<String, dynamic>? queryParameters,
  //     Options? options,
  // CancelToken? cancelToken,
  Future<dynamic> delete(String path,
      {Object? body,
      dynamic queryParams,
      Options? options,
      CancelToken? cancelToken}) async {
    dynamic responseJson;
    try {
      final uri = Uri.https(getDomain(), path, queryParams);
      final response = await dio
          .delete(uri.toString(),
              data: body, options: options, cancelToken: cancelToken)
          .timeout(const Duration(seconds: 10));
      responseJson = _returnResponse(response);
    } on Exception catch (e) {
      QcLog.e('Exception =============== $e');
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

  _returnResponse(Response response) {
    QcLog.i(" RESPONSE responseJson >>> : ${response.statusCode}");
    switch (response.statusCode) {
      case 200:
      case 201:
        QcLog.i(" _returnResponse 200 >>> : ");
        var responseJson = response.data;
        if (kDebugMode) prettyPrintJson(jsonEncode(responseJson));
        return responseJson;
      case 401:
      case 403:
        throw AuthFailException(response.statusMessage, "Auth");
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
