import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
// import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrintingWebview extends StatefulWidget {
  const PrintingWebview({Key? key}) : super(key: key);

  @override
  State<PrintingWebview> createState() => _PrintingWebviewState();
}

class _PrintingWebviewState extends State<PrintingWebview> {
  late WebViewController _webviewController;
  String _webviewUrl = 'WebViewのURL';
  double _height = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: _height,
            child: WebView(
              initialUrl: _webviewUrl,
              onWebViewCreated: (controller) async {
                _webviewController = controller;
              },
              onPageFinished: (_) async {
                double _contentHeight = double.parse(
                  await _webviewController.runJavascriptReturningResult(
                      'document.documentElement.scrollHeight;'),
                );
                setState(() {
                  _height = _contentHeight; // WebViewの高さを更新
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
