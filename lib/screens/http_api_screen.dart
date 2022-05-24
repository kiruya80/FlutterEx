import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterex/controllers/http_api_controller.dart';
import 'package:flutterex/datas/model/api_item.dart';
import 'package:flutterex/datas/model/response_model.dart';
import 'package:flutterex/network/api/api_list.dart';
import 'package:flutterex/screens/components/api_list_common_item.dart';
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
  //
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
  //   });
  //
  //   return result;
  // }

  @override
  Widget build(BuildContext context) {
    QcLog.e("HttpApiScreen =============");
    HttpApiController controller = Get.find<HttpApiController>();

    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: QcText.headline6(controller.title.value),
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
              color: Theme.of(context).colorScheme.background,
              width: Get.width,
              height: Get.height,
              child: FutureBuilder<List<ApiItem>>(
                future: controller.makeApiData(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<ApiItem>> snapshot) {
                  //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
                  if (snapshot.hasData == false) {
                    return Container(
                        child: Center(child: CircularProgressIndicator()));
                  } else if (snapshot.hasError) {
                    return Container(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.white),
                      ),
                    ));
                  } else {
                    List<ApiItem> items = snapshot.data!;
                    return Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int position) {
                          ApiItem item = items[position];

                          return Column(
                            children: <ApiListCommonItemForm>[
                              ApiListCommonItemForm(
                                item: item,
                                callback: (_item) async {
                                  QcLog.e('callback =============== $_item');
                                  controller.makeApi(context, item);
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  }
                },
              )),

          // child: Container(
          //     color: Theme.of(context).colorScheme.background,
          //     width: Get.width,
          //     height: Get.height,
          //     margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          //     child: SingleChildScrollView(
          //       scrollDirection: Axis.vertical,
          //       child: Column(
          //         children: [
          //           Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               children: [
          //                 Expanded(
          //                     child: QcText.subtitle1(
          //                   controller.api_get_posts.value,
          //                   maxLines: 20,
          //                 )),
          //                 SizedBox(
          //                   width: 20,
          //                 ),
          //                 Container(
          //                     width: 300.0,
          //                     child: OutlinedButton(
          //                         onPressed: () async {
          //                           try {
          //                             ResponseModel result =
          //                                 await ApiList().getPostList();
          //                             controller.api_get_posts.value =
          //                                 prettyPrintJson(result.bodyStr);
          //                           } catch (e) {
          //                             QcLog.e("getPostList error : $e");
          //                             // Get.defaultDialog(title: 'Error', middleText: '$e');
          //
          //                             Get.dialog(
          //                               AlertDialog(
          //                                 title: QcText.headline6('Error',
          //                                     fontColor:
          //                                         Theme.of(context).errorColor),
          //                                 content: Container(
          //                                   width: 400,
          //                                   height: 100,
          //                                   child: QcText.bodyText1(
          //                                     '$e',
          //                                     fontColor:
          //                                         Theme.of(context).errorColor,
          //                                     // maxLines: 1,
          //                                     // maxLine: 10,
          //                                   ),
          //                                 ),
          //                                 actions: [
          //                                   TextButton(
          //                                     child: Text("닫기"),
          //                                     onPressed: () => Get.back(),
          //                                   ),
          //                                   // null,
          //                                 ],
          //                               ),
          //                             );
          //                           }
          //                         },
          //                         style: OutlinedButton.styleFrom(
          //                           minimumSize: Size.fromHeight(80),
          //                           // primary: Colors.teal,
          //                           backgroundColor: Theme.of(context)
          //                               .colorScheme
          //                               .background,
          //                         ),
          //                         child: QcText.subtitle1(
          //                           'api_get_posts'.tr,
          //                           fontColor: Theme.of(context)
          //                               .colorScheme
          //                               .onBackground,
          //                         ))),
          //               ]),
          //           SizedBox(
          //             height: 20,
          //           ),
          //           Container(
          //             height: 2,
          //             color: Colors.black,
          //           ),
          //           Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               children: [
          //                 Expanded(
          //                     child: QcText.subtitle1(
          //                   controller.api_get_posts_1.value,
          //                 )),
          //                 SizedBox(
          //                   width: 20,
          //                 ),
          //                 Container(
          //                     width: 300.0,
          //                     child: OutlinedButton(
          //                         onPressed: () async {
          //                           // https://jsonplaceholder.typicode.com/posts/1
          //                           var result = await ApiList().getOnePost();
          //
          //                           String jsonTutorial = jsonEncode(result);
          //                           QcLog.e('jsonTutorial : $jsonTutorial');
          //
          //                           // JsonEncoder encoder =
          //                           //     new JsonEncoder.withIndent('  ');
          //                           // String prettyprint =
          //                           //     encoder.convert(result);
          //
          //                           // final prettyprint =
          //                           //     JsonEncoder.withIndent('  ')
          //                           //         .convert(result);
          //                           // controller.api_get_posts_1.value =
          //                           //     result.toString();
          //                         },
          //                         style: OutlinedButton.styleFrom(
          //                           minimumSize: Size.fromHeight(80),
          //                           // primary: Colors.teal,
          //                           backgroundColor: Theme.of(context)
          //                               .colorScheme
          //                               .background,
          //                         ),
          //                         child: QcText.subtitle1(
          //                           'api_get_posts_1'.tr,
          //                           fontColor: Theme.of(context)
          //                               .colorScheme
          //                               .onBackground,
          //                         ))),
          //               ]),
          //           SizedBox(
          //             height: 20,
          //           ),
          //           Container(
          //             height: 2,
          //             color: Colors.black,
          //           ),
          //           Row(
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               children: [
          //                 Expanded(
          //                     child: QcText.subtitle1(
          //                   controller.api_get_comments.value,
          //                   maxLines: 20,
          //                 )),
          //                 SizedBox(
          //                   width: 20,
          //                 ),
          //                 Container(
          //                     width: 300.0,
          //                     child: OutlinedButton(
          //                         onPressed: () async {
          //                           var result =
          //                               await ApiList().getPostComments();
          //                           controller.api_get_comments.value =
          //                               result.toString();
          //                         },
          //                         style: OutlinedButton.styleFrom(
          //                           minimumSize: Size.fromHeight(80),
          //                           // primary: Colors.teal,
          //                           backgroundColor: Theme.of(context)
          //                               .colorScheme
          //                               .background,
          //                         ),
          //                         child: QcText.subtitle1(
          //                           'api_get_comments'.tr,
          //                           fontColor: Theme.of(context)
          //                               .colorScheme
          //                               .onBackground,
          //                         ))),
          //               ]),
          //           SizedBox(
          //             height: 20,
          //           ),
          //           Container(
          //             height: 2,
          //             color: Colors.black,
          //           ),
          //           Row(
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               children: [
          //                 Expanded(
          //                     child: QcText.subtitle1(
          //                   controller.api_get_comments_1.value,
          //                 )),
          //                 SizedBox(
          //                   width: 20,
          //                 ),
          //                 Container(
          //                     width: 300.0,
          //                     child: OutlinedButton(
          //                         onPressed: () async {
          //                           // https://jsonplaceholder.typicode.com/posts/1
          //                           var result = await ApiList().getComments(
          //                               queryParams: {'postId': '1'});
          //                           QcLog.e('result ==== $result');
          //                           controller.api_get_comments_1.value =
          //                               result.toString();
          //                         },
          //                         style: OutlinedButton.styleFrom(
          //                           minimumSize: Size.fromHeight(80),
          //                           // primary: Colors.teal,
          //                           backgroundColor: Theme.of(context)
          //                               .colorScheme
          //                               .background,
          //                         ),
          //                         child: QcText.subtitle1(
          //                           'api_get_comments_1'.tr,
          //                           fontColor: Theme.of(context)
          //                               .colorScheme
          //                               .onBackground,
          //                         ))),
          //               ]),
          //           SizedBox(
          //             height: 20,
          //           ),
          //           Container(
          //             height: 2,
          //             color: Colors.black,
          //           ),
          //           Row(
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               children: [
          //                 Expanded(
          //                     child: QcText.subtitle1(
          //                   controller.api_post_posts.value,
          //                 )),
          //                 SizedBox(
          //                   width: 20,
          //                 ),
          //                 Container(
          //                     width: 300.0,
          //                     child: OutlinedButton(
          //                         onPressed: () async {
          //                           // https://jsonplaceholder.typicode.com/posts/1
          //                           var result = await ApiList().postSample();
          //                           QcLog.e('result ==== $result');
          //                           controller.api_post_posts.value =
          //                               result.toString();
          //                         },
          //                         style: OutlinedButton.styleFrom(
          //                           minimumSize: Size.fromHeight(80),
          //                           // primary: Colors.teal,
          //                           backgroundColor: Theme.of(context)
          //                               .colorScheme
          //                               .background,
          //                         ),
          //                         child: QcText.subtitle1(
          //                           'api_post_posts'.tr,
          //                           fontColor: Theme.of(context)
          //                               .colorScheme
          //                               .onBackground,
          //                         ))),
          //               ]),
          //           SizedBox(
          //             height: 20,
          //           ),
          //           Container(
          //             height: 2,
          //             color: Colors.black,
          //           ),
          //           Row(
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               children: [
          //                 Expanded(
          //                     child: QcText.subtitle1(
          //                   controller.api_put_posts.value,
          //                 )),
          //                 SizedBox(
          //                   width: 20,
          //                 ),
          //                 Container(
          //                     width: 300.0,
          //                     child: OutlinedButton(
          //                         onPressed: () async {
          //                           // https://jsonplaceholder.typicode.com/posts/1
          //                           var result = await ApiList().putample();
          //                           QcLog.e('result ==== $result');
          //                           controller.api_put_posts.value =
          //                               result.toString();
          //                         },
          //                         style: OutlinedButton.styleFrom(
          //                           minimumSize: Size.fromHeight(80),
          //                           // primary: Colors.teal,
          //                           backgroundColor: Theme.of(context)
          //                               .colorScheme
          //                               .background,
          //                         ),
          //                         child: QcText.subtitle1(
          //                           'api_put_posts'.tr,
          //                           fontColor: Theme.of(context)
          //                               .colorScheme
          //                               .onBackground,
          //                         ))),
          //               ]),
          //           SizedBox(
          //             height: 20,
          //           ),
          //           Container(
          //             height: 2,
          //             color: Colors.black,
          //           ),
          //           Row(
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               children: [
          //                 Expanded(
          //                     child: QcText.subtitle1(
          //                   controller.api_patch_posts.value,
          //                 )),
          //                 SizedBox(
          //                   width: 20,
          //                 ),
          //                 Container(
          //                     width: 300.0,
          //                     child: OutlinedButton(
          //                         onPressed: () async {
          //                           // https://jsonplaceholder.typicode.com/posts/1
          //                           var result = await ApiList().patchSample();
          //                           QcLog.e('result ==== $result');
          //                           controller.api_patch_posts.value =
          //                               result.toString();
          //                         },
          //                         style: OutlinedButton.styleFrom(
          //                           minimumSize: Size.fromHeight(80),
          //                           // primary: Colors.teal,
          //                           backgroundColor: Theme.of(context)
          //                               .colorScheme
          //                               .background,
          //                         ),
          //                         child: QcText.subtitle1(
          //                           'api_patch_posts'.tr,
          //                           fontColor: Theme.of(context)
          //                               .colorScheme
          //                               .onBackground,
          //                         ))),
          //               ]),
          //           SizedBox(
          //             height: 20,
          //           ),
          //           Container(
          //             height: 2,
          //             color: Colors.black,
          //           ),
          //           Row(
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               children: [
          //                 Expanded(
          //                     child: QcText.subtitle1(
          //                   controller.api_delete_posts.value,
          //                 )),
          //                 SizedBox(
          //                   width: 20,
          //                 ),
          //                 Container(
          //                     width: 300.0,
          //                     child: OutlinedButton(
          //                         onPressed: () async {
          //                           // https://jsonplaceholder.typicode.com/posts/1
          //                           var result = await ApiList().deleteSample();
          //                           QcLog.e('result ==== $result');
          //                           controller.api_delete_posts.value =
          //                               result.toString();
          //                         },
          //                         style: OutlinedButton.styleFrom(
          //                           minimumSize: Size.fromHeight(80),
          //                           // primary: Colors.teal,
          //                           backgroundColor: Theme.of(context)
          //                               .colorScheme
          //                               .background,
          //                         ),
          //                         child: QcText.subtitle1(
          //                           'api_delete_posts'.tr,
          //                           fontColor: Theme.of(context)
          //                               .colorScheme
          //                               .onBackground,
          //                         ))),
          //               ]),
          //         ],
          //       ),
          //     )),
        ),
      );
    });
  }
}
