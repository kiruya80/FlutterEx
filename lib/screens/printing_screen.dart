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
  FocusNode myFocusNode = new FocusNode();
  late WebViewController _webviewController;
  final textEdController = TextEditingController();
  PrintingController controller = Get.find<PrintingController>();

  @override
  void initState() {
    super.initState();
    myFocusNode.addListener(_focusNodeListener);
  }

  @override
  void dispose() {
    myFocusNode.removeListener(_focusNodeListener);

    super.dispose();
  }

  Future<Null> _focusNodeListener() async {
    if (myFocusNode.hasFocus) {
      QcLog.e('TextField got the focus');
    } else {
      QcLog.e('TextField lost the focus');
    }
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
            if (!FocusScope.of(context).hasPrimaryFocus) {
              FocusScope.of(context).unfocus();
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
                              // controller.saveTextValidate(); ??????
                              QcLog.e("onSaved : $value");
                              if (value != null && value.isNotEmpty) {
                                controller.webviewUrl.value = value;
                              }
                            },
                            validator: (value) {
                              QcLog.e("validator : $value");
                              if (value != null && value.isEmpty) {
                                return 'validator url??? ??????????????????';
                              }
                              return null;
                            },
                            hintText: 'url??? ??????????????????',
                            labelText: 'URL',
                            keyboardType: TextInputType.url,
                            controller: textEdController,
                            maxLines: 5,
                            focusNode: myFocusNode,
                            prefixIcon: Icon(Icons.web_outlined),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          child: Column(
                            children: [
                              ElevatedButton(
                                  onPressed: () async {
                                    if (controller.isTextValidate()!) {
                                      String moveUrl = controller
                                          .makeUrl(textEdController.text);
                                      if (moveUrl.isNotEmpty && moveUrl.isURL) {
                                        _webviewController.loadUrl(controller
                                            .makeUrl(textEdController.text));

                                        QcLog.e(
                                            "webviewUrl  ${controller.webviewUrl.value}");
                                        QcLog.e("url  ${controller.url.value}");
                                        // validation ??? ???????????? true ??? ????????????!
                                        // controller.saveTextValidate();

                                        FocusScope.of(context).unfocus();
                                        new TextEditingController().clear();
                                        textEdController.text = '';

                                        Get.snackbar(
                                          '???????????? ??????!',
                                          moveUrl + ' ???????????????',
                                          backgroundColor: Colors.black,
                                          colorText: Colors.white,
                                          snackPosition: SnackPosition.BOTTOM,
                                        );
                                      } else {
                                        Get.snackbar(
                                          '??????',
                                          'URL ???????????? ??????????????????',
                                          backgroundColor: Colors.black,
                                          colorText: Colors.white,
                                          snackPosition: SnackPosition.BOTTOM,
                                        );
                                      }
                                    }
                                  },
                                  child: Text('??????')),
                              SizedBox(
                                height: 20,
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
                                    }).catchError((error) {
                                      QcLog.e('error: $error');
                                    });
                                  },
                                  child: Icon(Icons.print)),
                            ],
                          ),
                        ),

                        SizedBox(
                          width: 20,
                        ),

                        Container(
                            child: Column(children: [
                          ElevatedButton(
                              onPressed: () async {
                                controller.isTextValidate();
                              },
                              child: Text('TextField validate')),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                controller.formKey.currentState?.reset();
                              },
                              child: Text('TextField reset')),
                        ]))

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
      );
    });
  }
}
