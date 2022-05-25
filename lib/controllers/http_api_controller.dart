import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterex/datas/model/api_item.dart';
import 'package:flutterex/datas/model/post_model.dart';
import 'package:flutterex/datas/model/response_model.dart';
import 'package:flutterex/network/api/api_list.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:flutterex/widget/dialog_widget.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class HttpApiController extends GetxController {
  var title = "HttpApiController".obs;
  List<ApiItem> apiItems = [];

  @override
  void onInit() {
    super.onInit();

    sampleDio();
  }

  Future<List<ApiItem>> makeApiData() async {
    apiItems = [];
    apiItems.add(new ApiItem(
        api: '[GET] Post List',
        apiStr: 'getPostList',
        errorStr: ''.obs,
        result: ''.obs,
        resultPretty: ''.obs));
    apiItems.add(new ApiItem(
        api: '[GET] One Post',
        apiStr: 'getOnePost',
        errorStr: ''.obs,
        result: ''.obs,
        resultPretty: ''.obs));
    apiItems.add(new ApiItem(
        api: '[GET] Post Comments',
        apiStr: 'getPostComments',
        errorStr: ''.obs,
        result: ''.obs,
        resultPretty: ''.obs));
    apiItems.add(new ApiItem(
        api: '[GET] Comments',
        apiStr: 'getComments',
        errorStr: ''.obs,
        result: ''.obs,
        resultPretty: ''.obs));
    apiItems.add(new ApiItem(
        api: '[POST] Sample',
        apiStr: 'postSample',
        errorStr: ''.obs,
        result: ''.obs,
        resultPretty: ''.obs));
    apiItems.add(new ApiItem(
        api: '[PUT] ample',
        apiStr: 'putample',
        errorStr: ''.obs,
        result: ''.obs,
        resultPretty: ''.obs));
    apiItems.add(new ApiItem(
        api: '[PATCH] Sample',
        apiStr: 'patchSample',
        errorStr: ''.obs,
        result: ''.obs,
        resultPretty: ''.obs));
    apiItems.add(new ApiItem(
        api: '[DELETE] Sample',
        apiStr: 'deleteSample',
        errorStr: ''.obs,
        result: ''.obs,
        resultPretty: ''.obs));

    return apiItems;
  }

  Dio dio = Dio();
  void sampleDio() {
    dio.options.baseUrl = 'https://www.jsonplaceholder.typicode.com';
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 3000;

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

  // https://jsonplaceholder.typicode.com/posts
  void getHttp() async {
    try {
      var response = await dio.get('/posts');
      // var response =
      //     await dio.get('https://jsonplaceholder.typicode.com/posts');
      // print(response);
      // QcLog.e('response == $response');
      QcLog.e('response == ${response.data}');
    } catch (e) {
      print(e);
    }
  }

  void makeApi(BuildContext context, ApiItem item) async {
    QcDialog.showProgress();
    try {
      var result;
      switch (item.apiStr) {
        case 'getPostList':
          result = await ApiList().getPostList();
          break;

        case 'getOnePost':
          result = await ApiList().getOnePost();
          break;

        case 'getPostComments':
          result = await ApiList().getPostComments();
          break;

        case 'getComments':
          result = await ApiList().getComments(queryParams: {'postId': '1'});
          break;

        case 'postSample':
          result = await ApiList().postSample(PostSample(
            title: 'foo',
            body: 'bar',
            userId: '1',
          ));
          break;

        case 'putSample':
          result = await ApiList().putSample();
          break;

        case 'patchSample':
          result = await ApiList().patchSample();
          break;

        case 'deleteSample':
          // result = await ApiList().deleteSample();
          getHttp();
          break;
      }
      QcDialog.dissmissProgress();
      item.resultPretty.value = prettyPrintJson(result.bodyStr);
    } catch (e) {
      QcDialog.dissmissProgress();
      QcLog.e("getPostList error : $e");
      showError(context, e.toString());
    }
  }

  String prettyPrintJson(String input) {
    // String jsonTutorial = jsonEncode(object);
    String result = '';
    const JsonDecoder decoder = JsonDecoder();
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final dynamic object = decoder.convert(input);
    final dynamic prettyString = encoder.convert(object);

    prettyString.split('\n').forEach((dynamic element) {
      result += element + '\n';
    });

    return result;
  }

  void showError(BuildContext context, String e) {
    QcDialog.dissmissProgress();
    Get.dialog(
      AlertDialog(
        title:
            QcText.headline6('Error', fontColor: Theme.of(context).errorColor),
        content: Container(
          width: 400,
          height: 100,
          child: QcText.bodyText1(
            '$e',
            fontColor: Theme.of(context).errorColor,
            // maxLines: 1,
            // maxLine: 10,
          ),
        ),
        actions: [
          TextButton(
            child: Text("닫기"),
            onPressed: () => Get.back(),
          ),
          // null,
        ],
      ),
    );
  }
}
