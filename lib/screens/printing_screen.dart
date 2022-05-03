import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterex/constants/constant.dart';
import 'package:flutterex/controllers/printing_controller.dart';
import 'package:flutterex/screens/components/text_style.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:flutterex/utils/printing_utils.dart';
// import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrintingScreen extends StatelessWidget {
  static const routeName = '/print';

  const PrintingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PrintingController controller = Get.find<PrintingController>();
    late WebViewController _webviewController;
    var url = '';
    final textEdController = TextEditingController();
    FocusScopeNode currentFocus = FocusScope.of(context);
    // currentFocus.unfocus(); // 키보드 사라지게

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
          //  FocusScope.of(context).unfocus();
          maintainBottomViewPadding: false,
          child: Column(
            children: <Widget>[
              Container(
                  // height: 80,
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            Print.e("value : $value");

                            if (value != null && value.isEmpty) {
                              return 'url을 입력해주세요';
                            } else {
                              url = value.toString();
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            // 텍스트필드의 외각선
                            border: InputBorder.none,
                            errorStyle: Get.textTheme.caption!.copyWith(
                              color: const Color(0xFFF7901E),
                            ),
                            filled: true,
                            hintText: 'url을 입력해주세요',
                            labelText: 'URL',
                          ),
                          style: Get.textTheme.bodyText1,
                          keyboardType: TextInputType.url,
                          controller: textEdController,
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            Print.e(
                                "ElevatedButton : ${textEdController.text}");
                            url = textEdController.text.trim();
                            if (url != null && url.isNotEmpty) {
                              Print.e("ElevatedButton : $url");
                              controller.webviewUrl.value = url;
                              _webviewController.loadUrl(url);
                            }
                          },
                          child: Text('이동'))
                    ],
                  )),
              Expanded(
                // height: _height,
                child: WebView(
                  debuggingEnabled: kDebugMode,
                  initialUrl: controller.webviewUrl.value,
                  javascriptMode: JavascriptMode.unrestricted,
                  allowsInlineMediaPlayback: true,
                  onWebViewCreated: (controller) async {
                    Print.e("onWebViewCreated ");
                    _webviewController = controller;
                  },
                  onPageFinished: (_) async {
                    double _contentHeight = double.parse(
                      await _webviewController.runJavascriptReturningResult(
                          'document.documentElement.scrollHeight;'),
                    );
                    Print.e("_contentHeight : $_contentHeight");
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          // onPressed: _showSources,
          // onPressed: geDirs,
          // onPressed: _printPdf,
          onPressed: () async {
            String? currentUrl = await _webviewController.currentUrl();
            Print.e("current url : $currentUrl");

            _webviewController
                .runJavascriptReturningResult(Constants.OUTER_HTML)
                .then((value) {
              PrintingUtils.readDomFromJS(value, currentUrl!, true);
            });
          },
          // onPressed: readCounter,
          // tooltip: 'Increment',
          child: Icon(Icons.add),
        ), // T
      );
    });
  }
}
