import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterex/controllers/base_controller.dart';
import 'package:flutterex/datas/model/api_item.dart';
import 'package:flutterex/datas/model/post_model.dart';
import 'package:flutterex/network/api/api_dio_list.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:flutterex/widget/dialog_widget.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:get/get.dart';

class DioApiController extends BaseController {
  List<ApiItem> apiItems = [];

  Future<List<ApiItem>> makeApiData() async {
    apiItems = [];
    apiItems.add(ApiItem(
      apiLibType: 'DIO',
      api: '[GET] Post List',
      apiStr: 'getPostList',
    ));
    apiItems.add(ApiItem(
      apiLibType: 'DIO',
      api: '[GET] One Post',
      apiStr: 'getOnePost',
    ));
    apiItems.add(ApiItem(
      apiLibType: 'DIO',
      api: '[GET] Post Comments',
      apiStr: 'getPostComments',
    ));
    apiItems.add(ApiItem(
      apiLibType: 'DIO',
      api: '[GET] Comments',
      apiStr: 'getComments',
    ));
    apiItems.add(ApiItem(
      apiLibType: 'DIO',
      api: '[POST] Sample',
      apiStr: 'postSample',
    ));
    apiItems.add(ApiItem(
      apiLibType: 'DIO',
      api: '[PUT] Sample',
      apiStr: 'putSample',
    ));
    apiItems.add(ApiItem(
      apiLibType: 'DIO',
      api: '[PATCH] Sample',
      apiStr: 'patchSample',
    ));
    apiItems.add(ApiItem(
      apiLibType: 'DIO',
      api: '[DELETE] Sample',
      apiStr: 'deleteSample',
    ));

    return apiItems;
  }

  void makeApi(BuildContext context, ApiItem item) async {
    QcDialog.showProgress();
    try {
      var result;
      switch (item.apiStr) {
        case 'getPostList':
          result = await ApiDioList().getPostList();
          break;

        case 'getOnePost':
          result = await ApiDioList().getOnePost();
          break;

        case 'getPostComments':
          result = await ApiDioList().getPostComments();
          break;

        case 'getComments':
          result = await ApiDioList().getComments(queryParams: {'postId': '1'});
          break;

        case 'postSample':
          result = await ApiDioList().postSample(PostSample(
            title: 'foo11',
            body: 'bar22',
            userId: 33,
          ));
          break;

        case 'putSample':
          result = await ApiDioList().putSample(PostSample(
            title: 'foo12121212',
            body: 'bar3434343434',
            userId: 33,
          ));
          break;

        case 'patchSample':
          result = await ApiDioList().patchSample({
            "title": 'foooooooooooooooo',
          });
          break;

        case 'deleteSample':
          result = await ApiDioList().deleteSample('1');
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

  //
  // void makeApiToDio(BuildContext context, ApiItem item) async {
  //   QcDialog.showProgress();
  //   try {
  //     var result;
  //     switch (item.apiStr) {
  //       case 'dioSample':
  //         result = await ApiListDio().getPostList();
  //         break;
  //
  //       default:
  //         break;
  //     }
  //     QcDialog.dissmissProgress();
  //     item.resultPretty.value = prettyPrintJson(result.bodyStr);
  //   } catch (e) {
  //     QcDialog.dissmissProgress();
  //     QcLog.e("getPostList error : $e");
  //     showError(context, e.toString());
  //   }
  // }

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
