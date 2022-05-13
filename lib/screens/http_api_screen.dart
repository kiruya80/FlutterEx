import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterex/controllers/http_api_controller.dart';
import 'package:flutterex/datas/model/post_model.dart';
import 'package:flutterex/datas/model/response_model.dart';
import 'package:flutterex/network/api/api_list.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:get/get.dart';

/// 샘플 url
/// https://jsonplaceholder.typicode.com/
///
class HttpApiScreen extends StatelessWidget {
  static const routeName = '/httpApi';

  const HttpApiScreen({Key? key}) : super(key: key);

  // String prettyPrintJson(String input) {
  //   // String jsonTutorial = jsonEncode(object);
  //   String result = '';
  //   const JsonDecoder decoder = JsonDecoder();
  //   const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  //   final dynamic object = decoder.convert(input);
  //   final dynamic prettyString = encoder.convert(object);
  //
  //   prettyString.split('\n').forEach((dynamic element) {
  //     result += element + '\n';
  //
  //     Print.e('element ============================= ');
  //     Print.w(element);
  //     print(element);
  //   });
  //
  //   return result;
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

  @override
  Widget build(BuildContext context) {
    Print.e("HttpApiScreen =============");
    HttpApiController controller = Get.find<HttpApiController>();

    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title:
              QcText.headline6(controller.title.value, fontColor: Colors.white),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: SafeArea(
          // maintainBottomViewPadding 키보드가 올라온 경우 밀어낼지 덮을지 결정
          // maintainBottomViewPadding: false,
          child: Container(
              color: Colors.white,
              width: Get.width,
              height: Get.height,
              margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: QcText.subtitle1(
                            controller.api_get_posts.value,
                            // multiLine: false,
                            maxLine: 20,
                          )),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                              width: 300.0,
                              child: OutlinedButton(
                                  onPressed: () async {
                                    ResponseModel result =
                                        await ApiList().getPostList();

                                    controller.api_get_posts.value =
                                        prettyPrintJson(result.bodyStr);
                                  },
                                  style: OutlinedButton.styleFrom(
                                    minimumSize: Size.fromHeight(80),
                                    primary: Colors.teal,
                                    backgroundColor: Colors.white,
                                  ),
                                  child: QcText.subtitle1('api_get_posts'.tr))),
                        ]),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 2,
                      color: Colors.black,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: QcText.subtitle1(
                            controller.api_get_posts_1.value,
                            multiLine: true,
                          )),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                              width: 300.0,
                              child: OutlinedButton(
                                  onPressed: () async {
                                    // https://jsonplaceholder.typicode.com/posts/1
                                    var result = await ApiList().getOnePost();

                                    String jsonTutorial = jsonEncode(result);
                                    Print.e('jsonTutorial : $jsonTutorial');

                                    // JsonEncoder encoder =
                                    //     new JsonEncoder.withIndent('  ');
                                    // String prettyprint =
                                    //     encoder.convert(result);

                                    // final prettyprint =
                                    //     JsonEncoder.withIndent('  ')
                                    //         .convert(result);
                                    // controller.api_get_posts_1.value =
                                    //     result.toString();
                                  },
                                  style: OutlinedButton.styleFrom(
                                    minimumSize: Size.fromHeight(80),
                                    primary: Colors.teal,
                                    backgroundColor: Colors.white,
                                  ),
                                  child:
                                      QcText.subtitle1('api_get_posts_1'.tr))),
                        ]),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 2,
                      color: Colors.black,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: QcText.subtitle1(
                            controller.api_get_comments.value,
                            // multiLine: false,
                            maxLine: 20,
                          )),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                              width: 300.0,
                              child: OutlinedButton(
                                  onPressed: () async {
                                    var result =
                                        await ApiList().getPostComments();
                                    controller.api_get_comments.value =
                                        result.toString();
                                  },
                                  style: OutlinedButton.styleFrom(
                                    minimumSize: Size.fromHeight(80),
                                    primary: Colors.teal,
                                    backgroundColor: Colors.white,
                                  ),
                                  child:
                                      QcText.subtitle1('api_get_comments'.tr))),
                        ]),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 2,
                      color: Colors.black,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: QcText.subtitle1(
                            controller.api_get_comments_1.value,
                            multiLine: true,
                          )),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                              width: 300.0,
                              child: OutlinedButton(
                                  onPressed: () async {
                                    // https://jsonplaceholder.typicode.com/posts/1
                                    var result = await ApiList().getComments(
                                        queryParams: {'postId': '1'});
                                    Print.e('result ==== $result');
                                    controller.api_get_comments_1.value =
                                        result.toString();
                                  },
                                  style: OutlinedButton.styleFrom(
                                    minimumSize: Size.fromHeight(80),
                                    primary: Colors.teal,
                                    backgroundColor: Colors.white,
                                  ),
                                  child: QcText.subtitle1(
                                      'api_get_comments_1'.tr))),
                        ]),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 2,
                      color: Colors.black,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: QcText.subtitle1(
                            controller.api_post_posts.value,
                            multiLine: true,
                          )),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                              width: 300.0,
                              child: OutlinedButton(
                                  onPressed: () async {
                                    // https://jsonplaceholder.typicode.com/posts/1
                                    var result = await ApiList().postSample();
                                    Print.e('result ==== $result');
                                    controller.api_post_posts.value =
                                        result.toString();
                                  },
                                  style: OutlinedButton.styleFrom(
                                    minimumSize: Size.fromHeight(80),
                                    primary: Colors.teal,
                                    backgroundColor: Colors.white,
                                  ),
                                  child:
                                      QcText.subtitle1('api_post_posts'.tr))),
                        ]),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 2,
                      color: Colors.black,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: QcText.subtitle1(
                            controller.api_put_posts.value,
                            multiLine: true,
                          )),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                              width: 300.0,
                              child: OutlinedButton(
                                  onPressed: () async {
                                    // https://jsonplaceholder.typicode.com/posts/1
                                    var result = await ApiList().putample();
                                    Print.e('result ==== $result');
                                    controller.api_put_posts.value =
                                        result.toString();
                                  },
                                  style: OutlinedButton.styleFrom(
                                    minimumSize: Size.fromHeight(80),
                                    primary: Colors.teal,
                                    backgroundColor: Colors.white,
                                  ),
                                  child: QcText.subtitle1('api_put_posts'.tr))),
                        ]),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 2,
                      color: Colors.black,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: QcText.subtitle1(
                            controller.api_patch_posts.value,
                            multiLine: true,
                          )),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                              width: 300.0,
                              child: OutlinedButton(
                                  onPressed: () async {
                                    // https://jsonplaceholder.typicode.com/posts/1
                                    var result = await ApiList().patchSample();
                                    Print.e('result ==== $result');
                                    controller.api_patch_posts.value =
                                        result.toString();
                                  },
                                  style: OutlinedButton.styleFrom(
                                    minimumSize: Size.fromHeight(80),
                                    primary: Colors.teal,
                                    backgroundColor: Colors.white,
                                  ),
                                  child:
                                      QcText.subtitle1('api_patch_posts'.tr))),
                        ]),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 2,
                      color: Colors.black,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: QcText.subtitle1(
                            controller.api_delete_posts.value,
                            multiLine: true,
                          )),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                              width: 300.0,
                              child: OutlinedButton(
                                  onPressed: () async {
                                    // https://jsonplaceholder.typicode.com/posts/1
                                    var result = await ApiList().deleteSample();
                                    Print.e('result ==== $result');
                                    controller.api_delete_posts.value =
                                        result.toString();
                                  },
                                  style: OutlinedButton.styleFrom(
                                    minimumSize: Size.fromHeight(80),
                                    primary: Colors.teal,
                                    backgroundColor: Colors.white,
                                  ),
                                  child:
                                      QcText.subtitle1('api_delete_posts'.tr))),
                        ]),
                  ],
                ),
              )),
        ),
      );
    });
  }
}
