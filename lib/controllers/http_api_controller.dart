import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterex/controllers/base_controller.dart';
import 'package:flutterex/datas/model/api_item.dart';
import 'package:flutterex/datas/model/post_model.dart';
import 'package:flutterex/network/api/api_http_list.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:flutterex/widget/dialog_widget.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:get/get.dart';

class HttpApiController extends BaseController {
  List<ApiItem> apiItems = [];

  Future<List<ApiItem>> makeApiData() async {
    apiItems = [];
    apiItems.add(ApiItem(
      apiLibType: 'Http',
      api: '[GET] Post List',
      apiStr: 'getPostList',
    ));
    apiItems.add(ApiItem(
      apiLibType: 'Http',
      api: '[GET] One Post',
      apiStr: 'getOnePost',
    ));
    apiItems.add(ApiItem(
      apiLibType: 'Http',
      api: '[GET] Post Comments',
      apiStr: 'getPostComments',
    ));
    apiItems.add(ApiItem(
      apiLibType: 'Http',
      api: '[GET] Comments',
      apiStr: 'getComments',
    ));
    apiItems.add(ApiItem(
      apiLibType: 'Http',
      api: '[POST] Sample',
      apiStr: 'postSample',
    ));
    apiItems.add(ApiItem(
      apiLibType: 'Http',
      api: '[PUT] Sample',
      apiStr: 'putSample',
    ));
    apiItems.add(ApiItem(
      apiLibType: 'Http',
      api: '[PATCH] Sample',
      apiStr: 'patchSample',
    ));
    apiItems.add(ApiItem(
      apiLibType: 'Http',
      api: '[DELETE] Sample',
      apiStr: 'deleteSample',
    ));
    apiItems.add(ApiItem(
      apiLibType: 'DIO',
      api: '[DIO] Sample',
      apiStr: 'dioSample',
    ));

    return apiItems;
  }

  void makeApi(BuildContext context, ApiItem item) async {
    QcDialog.showProgress();
    try {
      var result;
      switch (item.apiStr) {
        case 'getPostList':
          result = await ApiHttpList().getPostList();
          break;

        case 'getOnePost':
          result = await ApiHttpList().getOnePost();
          break;

        case 'getPostComments':
          result = await ApiHttpList().getPostComments();
          break;

        case 'getComments':
          result =
              await ApiHttpList().getComments(queryParams: {'postId': '1'});
          break;

        case 'postSample':
          result = await ApiHttpList().postSample(PostSample(
            title: 'foo11',
            body: 'bar22',
            userId: 33,
          ));
          break;

        case 'putSample':
          result = await ApiHttpList().putSample(PostSample(
            title: 'foo12121212',
            body: 'bar3434343434',
            userId: 33,
          ));
          break;

        case 'patchSample':
          result = await ApiHttpList().patchSample({
            "title": 'foooooooooooooooo',
          });
          break;

        case 'deleteSample':
          result = await ApiHttpList().deleteSample('1');
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
