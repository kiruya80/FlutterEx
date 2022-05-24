import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterex/datas/model/api_item.dart';
import 'package:flutterex/datas/model/response_model.dart';
import 'package:flutterex/network/api/api_list.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:flutterex/widget/dialog_widget.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:get/get.dart';

class HttpApiController extends GetxController {
  var title = "HttpApiController".obs;
  List<ApiItem> apiItems = [];

  // var api_get_posts = ''.obs;
  // var api_get_posts_1 = ''.obs;
  // var api_get_comments = ''.obs;
  // var api_get_comments_1 = ''.obs;
  // var api_post_posts = ''.obs;
  // var api_put_posts = ''.obs;
  // var api_patch_posts = ''.obs;
  // var api_delete_posts = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<List<ApiItem>> makeApiData() async {
    apiItems = [];
    apiItems.add(new ApiItem(
        api: 'Get Post List',
        apiStr: 'getPostList',
        errorStr: ''.obs,
        result: ''.obs,
        resultPretty: ''.obs));
    apiItems.add(new ApiItem(
        api: 'getOnePost',
        apiStr: 'getOnePost',
        errorStr: ''.obs,
        result: ''.obs,
        resultPretty: ''.obs));
    apiItems.add(new ApiItem(
        api: 'getPostComments',
        apiStr: 'getPostComments',
        errorStr: ''.obs,
        result: ''.obs,
        resultPretty: ''.obs));
    apiItems.add(new ApiItem(
        api: 'getComments',
        apiStr: 'getComments',
        errorStr: ''.obs,
        result: ''.obs,
        resultPretty: ''.obs));
    apiItems.add(new ApiItem(
        api: 'postSample',
        apiStr: 'postSample',
        errorStr: ''.obs,
        result: ''.obs,
        resultPretty: ''.obs));
    apiItems.add(new ApiItem(
        api: 'putample',
        apiStr: 'putample',
        errorStr: ''.obs,
        result: ''.obs,
        resultPretty: ''.obs));
    apiItems.add(new ApiItem(
        api: 'patchSample',
        apiStr: 'patchSample',
        errorStr: ''.obs,
        result: ''.obs,
        resultPretty: ''.obs));
    apiItems.add(new ApiItem(
        api: 'deleteSample',
        apiStr: 'deleteSample',
        errorStr: ''.obs,
        result: ''.obs,
        resultPretty: ''.obs));

    return apiItems;
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
          result = await ApiList().postSample();
          break;

        case 'putample':
          result = await ApiList().putample();
          break;

        case 'patchSample':
          result = await ApiList().patchSample();
          break;

        case 'deleteSample':
          result = await ApiList().deleteSample();
          break;
      }
      QcDialog.dissmissProgress();
      item.resultPretty.value = prettyPrintJson(result.bodyStr);
    } catch (e) {
      QcDialog.dissmissProgress();
      QcLog.e("getPostList error : $e");
      // Get.defaultDialog(title: 'Error', middleText: '$e');
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
