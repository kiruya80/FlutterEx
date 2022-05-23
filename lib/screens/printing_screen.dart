import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterex/constants/constant.dart';
import 'package:flutterex/controllers/printing_controller.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:flutterex/utils/printing_utils.dart';
import 'package:flutterex/widget/textformfield_widget.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';

class PrintingScreen extends StatefulWidget {
  static const routeName = '/print';

  const PrintingScreen({Key? key}) : super(key: key);

  @override
  _PrintingScreenState createState() => _PrintingScreenState();
}

class _PrintingScreenState extends State<PrintingScreen> {
  late FocusNode myFocusNode;
  late WebViewController _webviewController;
  final textEdController = TextEditingController();
  PrintingController controller = Get.find<PrintingController>();
  final formKey = GlobalKey<FormState>();

  // FocusScopeNode currentFocus = FocusScope.of(context);

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            //  FocusScope.of(context).unfocus();
            // maintainBottomViewPadding: false,
            child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Column(
            children: <Widget>[
              Container(
                // color: Theme.of(context).colorScheme.background,
                // height: 200,
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
                child: Form(
                    key: controller.formKey,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            // flex: 1,
                            child:
                                QcText.bodyText1(controller.webviewUrl.value)),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          // flex: 1,
                          // SingleChildScrollView
                          child: QcTextFormField.bodyText1(
                            onSaved: (value) {
                              // controller.saveTextValidate(); 필요
                              QcLog.e("onSaved : $value");
                              if (value != null && value.isNotEmpty) {
                                controller.webviewUrl.value = value;
                              }
                            },
                            validator: (value) {
                              QcLog.e("validator : $value");
                              if (value != null && value.isEmpty) {
                                return 'validator url을 입력해주세요';
                              }
                              return null;
                            },
                            hintText: 'url을 입력해주세요',
                            labelText: 'URL',
                            keyboardType: TextInputType.url,
                            controller: textEdController,
                            maxLines: 5,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              if (controller.isTextValidate()!) {
                                String moveUrl =
                                    controller.makeUrl(textEdController.text);
                                if (moveUrl.isNotEmpty && moveUrl.isURL) {
                                  _webviewController.loadUrl(controller
                                      .makeUrl(textEdController.text));

                                  QcLog.e(
                                      "webviewUrl  ${controller.webviewUrl.value}");
                                  QcLog.e("url  ${controller.url.value}");
                                  // validation 이 성공하면 true 가 리턴돼요!
                                  // controller.saveTextValidate();

                                  FocusScope.of(context).unfocus();
                                  new TextEditingController().clear();
                                  textEdController.text = '';

                                  Get.snackbar(
                                    '웹페이지 이동!',
                                    moveUrl + ' 이동합니다',
                                    backgroundColor: Colors.black,
                                    colorText: Colors.white,
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                } else {
                                  Get.snackbar(
                                    '알림',
                                    'URL 형식으로 입력해주세요',
                                    backgroundColor: Colors.black,
                                    colorText: Colors.white,
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                }
                              }
                            },
                            child: Text('이동')),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              String? currentUrl =
                                  await _webviewController.currentUrl();
                              QcLog.e(
                                  "current url : $currentUrl , ${controller.webviewUrl.value}");

                              _webviewController
                                  .runJavascriptReturningResult(
                                      Constants.OUTER_HTML)
                                  .then((value) {
                                PrintingUtils.readDomFromJS(
                                    value, currentUrl!, true);
                              });
                            },
                            child: Icon(Icons.print)),
                        // IconButton(onPressed: null, icon: Icon(Icons.print))
                      ],
                    )),
              ),
              Expanded(
                // height: _height,
                child: WebView(
                  debuggingEnabled: kDebugMode,
                  initialUrl: controller.webviewUrl.value,
                  javascriptMode: JavascriptMode.unrestricted,
                  allowsInlineMediaPlayback: true,
                  onWebViewCreated: (controller) async {
                    QcLog.e("onWebViewCreated ");
                    _webviewController = controller;
                  },
                  onPageFinished: (url) async {
                    controller.webviewUrl.value = url;

                    double _contentHeight = double.parse(
                      await _webviewController.runJavascriptReturningResult(
                          'document.documentElement.scrollHeight;'),
                    );
                    QcLog.e("_contentHeight : $_contentHeight");
                  },
                ),
              ),
            ],
          ),
        )),

        // floatingActionButton: FloatingActionButton(
        //   onPressed: () async {
        //     String? currentUrl = await _webviewController.currentUrl();
        //     Print.e("current url : $currentUrl");
        //
        //     _webviewController
        //         .runJavascriptReturningResult(Constants.OUTER_HTML)
        //         .then((value) {
        //       PrintingUtils.readDomFromJS(value, currentUrl!, true);
        //     });
        //   },
        //   child: Icon(Icons.add),
        // ),
      );
    });
  }
}
