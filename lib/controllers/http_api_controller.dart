import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterex/datas/model/api_item.dart';
import 'package:flutterex/datas/model/post_model.dart';
import 'package:flutterex/network/api/api_list.dart';
import 'package:flutterex/network/api/api_list_dio.dart';
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
  }

  Future<List<ApiItem>> makeApiData() async {
    apiItems = [];
    apiItems.add(new ApiItem(
      apiLibType: 'Http',
      api: '[GET] Post List',
      apiStr: 'getPostList',
    ));
    apiItems.add(new ApiItem(
      apiLibType: 'Http',
      api: '[GET] One Post',
      apiStr: 'getOnePost',
    ));
    apiItems.add(new ApiItem(
      apiLibType: 'Http',
      api: '[GET] Post Comments',
      apiStr: 'getPostComments',
    ));
    apiItems.add(new ApiItem(
      apiLibType: 'Http',
      api: '[GET] Comments',
      apiStr: 'getComments',
    ));
    apiItems.add(new ApiItem(
      apiLibType: 'Http',
      api: '[POST] Sample',
      apiStr: 'postSample',
    ));
    apiItems.add(new ApiItem(
      apiLibType: 'Http',
      api: '[PUT] Sample',
      apiStr: 'putSample',
    ));
    apiItems.add(new ApiItem(
      apiLibType: 'Http',
      api: '[PATCH] Sample',
      apiStr: 'patchSample',
    ));
    apiItems.add(new ApiItem(
      apiLibType: 'Http',
      api: '[DELETE] Sample',
      apiStr: 'deleteSample',
    ));
    apiItems.add(new ApiItem(
      apiLibType: 'DIO',
      api: '[DIO] Sample',
      apiStr: 'dioSample',
    ));

    return apiItems;
  }

  void makeApi(BuildContext context, ApiItem item) async {
    if (item.apiLibType == 'DIO') {
      makeApiToDio(context, item);
    } else {
      makeApiToHttp(context, item);
    }
  }


  void makeApiToHttp(BuildContext context, ApiItem item) async {
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
            title: 'foo11',
            body: 'bar22',
            userId: 33,
          ));
          break;

        case 'putSample':
          result = await ApiList().putSample(PostSample(
            title: 'foo12121212',
            body: 'bar3434343434',
            userId: 33,
          ));
          break;

        case 'patchSample':
          result = await ApiList().patchSample({
            "title": 'foooooooooooooooo',
          });
          break;

        case 'deleteSample':
          result = await ApiList().deleteSample('1');
          break;

        default:
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

  void makeApiToDio(BuildContext context, ApiItem item) async {
    QcDialog.showProgress();
    try {
      var result;
      switch (item.apiStr) {
        case 'dioSample':
          result = await ApiListDio().getPostList();
          // getHttpDio();
          break;

        default:
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

  // https://jsonplaceholder.typicode.com/posts
  // void getHttpDio() async {
  //   try {
  //     var response =
  //         await dio.get('https://jsonplaceholder.typicode.com/posts/1');
  //     // var response =
  //     //     await dio.get('https://jsonplaceholder.typicode.com/posts');
  //     // print(response);
  //     // QcLog.e('response == $response');
  //     QcLog.e('response == ${response.data}');
  //   } catch (e) {
  //     print(e);
  //   }
  // }

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
            child: QcText.bodyText1("닫기"),
            onPressed: () => Get.back(),
          ),
          // null,
        ],
      ),
    );
  }
}
