import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:flutterex/utils/print_log.dart';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

void sample() {
  runApp(const MyApp2('Flutter ex'));
  // runApp(  PDFSave());
}

class MyApp2 extends StatelessWidget {
  const MyApp2(this.title, {Key? key}) : super(key: key);

  final String title;

  // 직접 호출 출력
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GoToPrintApp(title: ''),
    );
  }
}

class GoToPrintApp extends StatefulWidget {
  const GoToPrintApp({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<GoToPrintApp> createState() => GoToPrintAppState();
}

class GoToPrintAppState extends State<GoToPrintApp> {
  @override
  void initState() {
    super.initState();
    // generateExampleDocument();
  }
  //
  // void _showSources() {
  //   ul.launch(
  //       // 'https://github.com/DavBfr/dart_pdf/blob/master/demo/lib/examples/${examples[_tab].file}',
  //       'https://smartall-mid-web-test.wjthinkbig.com/');
  // }

  late List<Directory>? dir;
  late String _path;

  void init() async {
    final directory = await getApplicationDocumentsDirectory();
    _path = directory.path;
  }

  var cntUrl = 0;
  // initialUrl: 'https://www.wjthinkbig.com/',
  // initialUrl: 'https://www.daum.net/',
  // initialUrl: 'https://smartall-mid-web-test.wjthinkbig.com/',
  // initialUrl: 'https://flutter-ko.dev/9',
  var urllist = [
    'https://m.naver.com/',
    'https://www.daum.net/',
    'https://www.wjthinkbig.com/',
    'https://smartall-mid-web-test.wjthinkbig.com/',
  ];
  var urlTitle = 'url 변경';
  // https://stackoverflow.com/questions/66513977/is-there-any-way-to-parse-html-created-with-javascript-in-flutter
  // https://clein8.tistory.com/entry/Flutter-%EC%95%B1%EC%97%90-%EC%9B%B9%EB%B7%B0Webview-%EC%B6%94%EA%B0%80%ED%95%98%EA%B8%B0-webviewflutter
  @override
  Widget build(BuildContext context) {
    // WebViewController _controller;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 80,
              child: GestureDetector(
                onTap: () {
                  QcLog.e("onTap === ");
                  // writeCounter('파일 저장하기');
                  cntUrl++;
                  if (cntUrl == 4) {
                    cntUrl = 0;
                  }
                  _controller.loadUrl(urllist[cntUrl]);
                },
                child: Text(
                  'url변경',
                ),
              ),
            ),
            Container(
                width: double.infinity,
                height: 550,
                child: WebView(
                  initialUrl: 'https://m.naver.com/',
                  javascriptMode: JavascriptMode.unrestricted,
                  allowsInlineMediaPlayback: false,
                  onWebViewCreated: (controller) {
                    _controller = controller;
                    // QcLog(_controller.currentUrl());
                  },
                  onProgress: (int progress) {
                    // QcLog.d('WebView is loading (progress : $progress%)');
                  },
                  onPageStarted: (String url) {
                    QcLog.e('Page started loading: $url');
                  },
                  javascriptChannels: {
                    JavascriptChannel(
                        name: 'flutter_webview',
                        onMessageReceived: (message) {
                          // final data = jsonDecode(message.message);
                        })
                  },
                  navigationDelegate: (request) => NavigationDecision.navigate,
                  backgroundColor: const Color(0x00000000),
                  onPageFinished: (String url) {
                    // Timer(Duration(seconds: 3), () {
                    //   QcLog.e("onPageFinished Duration 3 ============== $url ");
                    //   urlStr = url;
                    //   _printPdf();
                    //   // readJS();
                    // });
                    urlStr = url;
                    Future.delayed(const Duration(milliseconds: 3000), () {
                      setState(() {
                        QcLog.e(
                            "onPageFinished Duration 3 ============== $url ");
                        // _printPdf();
                        // readDomFromJS();
                      });
                    });
                  },
                  onWebResourceError: (error) {
                    QcLog.e('onWebResourceError: $error');
                  },
                ))
          ],
        ),
      ),

      // body:
      // Container(
      // width: double.infinity,
      // height: double.infinity,
      // child:  WebView(
      //   // initialUrl: 'https://www.wjthinkbig.com/',
      //   initialUrl: 'https://m.naver.com/',
      //   // initialUrl: 'https://www.daum.net/',
      //   // initialUrl: 'https://smartall-mid-web-test.wjthinkbig.com/',
      //
      //   // initialUrl: 'https://flutter-ko.dev/9',
      //   javascriptMode: JavascriptMode.unrestricted,
      //   allowsInlineMediaPlayback: false,
      //   onWebViewCreated: (controller) {
      //     _controller = controller;
      //     // print(_controller.currentUrl());
      //   },
      //   onProgress: (int progress) {
      //     // Print.d('WebView is loading (progress : $progress%)');
      //   },
      //   onPageStarted: (String url) {
      //     Print.e('Page started loading: $url');
      //   },
      //   javascriptChannels: {
      //     JavascriptChannel(
      //         name: 'flutter_webview',
      //         onMessageReceived: (message) {
      //           // final data = jsonDecode(message.message);
      //
      //         }
      //     )
      //   },
      //
      //   navigationDelegate: (request) => NavigationDecision.navigate,
      //   backgroundColor: const Color(0x00000000),
      //   onPageFinished: (String url) {
      //     // Timer(Duration(seconds: 3), () {
      //     //   Print.e("onPageFinished Duration 3 ============== $url ");
      //     //   urlStr = url;
      //     //   _printPdf();
      //     //   // readJS();
      //     // });
      //     urlStr = url;
      //     Future.delayed(const Duration(milliseconds: 3000), () {
      //       setState(() {
      //         Print.e("onPageFinished Duration 3 ============== $url ");
      //         // _printPdf();
      //         // readDomFromJS();
      //       });
      //     });
      //   },
      //
      //   onWebResourceError: (error) {
      //     Print.e('onWebResourceError: $error');
      //   },
      // ),
      // ),

      floatingActionButton: FloatingActionButton(
        // onPressed: _showSources,
        // onPressed: geDirs,
        // onPressed: _printPdf,
        onPressed: readDomFromJS,
        // onPressed: readCounter,
        // tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  late WebViewController _controller;

  /**
   * webview에서  style 까지 가져온다
   * 프린터로 넘기면 화면은 맞지 않다
   *
   * 중등 - 로그인 화면은 나오지만 비율 위치 등 맞지 않음
   * m네이버 - 화면은 나오지만 빠진것들과 밖으로 빠지는 부분등이 보임
   *
   */
  void readDomFromJS() async {
    // String html = await _controller.evaluateJavascript("window.document.getElementsByTagName('html')[0].outerHTML;");
    // String html = await _controller.evaluateJavascript(
    //     "encodeURIComponent(document.documentElement.outerHTML)");
    String html = await _controller.runJavascriptReturningResult(
        "encodeURIComponent(document.documentElement.outerHTML)");
    QcLog.e("html ============== $html");
    var data = Uri.decodeComponent(html);
    QcLog.e("data ============== $data");
    // encodeURIComponent(document.documentElement.outerHTML)"

    // final decodeData = utf8.decode(html.); // 한글 깨짐 인코딩

    /**
     * 프린터 내용 가로 세로 기준
     * 가로로
     *  height: PdfPageFormat.a4.width,
     *  width: PdfPageFormat.a4.height,
     *  세로로
     *  height: PdfPageFormat.a4.height,
     *  width: PdfPageFormat.a4.width,
     *
     * 용지 가로 세로
     * 가로로
     * Printing.layoutPdf(
     * format: PdfPageFormat.a4.landscape,
     * 세로로
     * Printing.layoutPdf(
     * format: PdfPageFormat.a4.portrait,
     * 또는 위 내용과 같이
     *
     *
     * baseUrl : 이미지등등
     *   상대 경로가 포함된 경우 변환기는 이미지의 전체 절대 URL을 파악하기 위해 "BaseUrl"이 필요
     */
    await Printing.layoutPdf(
        format: PdfPageFormat.a4.landscape,
        // format: PdfPageFormat.a4.copyWith(
        //     // height: PdfPageFormat.a4.width,
        //     // width: PdfPageFormat.a4.height,
        //     height: 21.0 * cm,
        //     width:  29.7 * cm,
        //     marginBottom: 0,
        //     marginLeft: 0,
        //     marginRight: 0,
        //     marginTop: 0),
        // dynamicLayout : false,
        // usePrinterSettings : true,
        onLayout: (PdfPageFormat format) async => await Printing.convertHtml(
              // baseUrl: urlStr,
              baseUrl: urllist[cntUrl],
              format: PdfPageFormat.a4.landscape,
              // format: PdfPageFormat.a4.copyWith(
              //         height: 21.0 * cm,
              //         width:  29.7 * cm,
              //         marginBottom: 0,
              //         marginLeft: 0,
              //         marginRight: 0,
              //         marginTop: 0),
              html: data,
            ));
  }

  static const double point = 1.0;
  static const double inch = 72.0;
  static const double cm = inch / 2.54;
  static const double mm = inch / 25.4;
  var urlStr = 'https://smartall-mid-web-test.wjthinkbig.com/';

//Now I define the async function to make the request
//   void makeRequest() async{
//     var response = await http.get(urlStr);
//     //If the http request is successful the statusCode will be 200
//     if(response.statusCode == 200){
//       String htmlToParse = response.body;
//       print(htmlToParse);
//     }
//   }

  /**
   * 프린터로 보내기
   * url 로 style 제외하고 가져온다
   *
   * 중등 -로그인 화면 안나옴
   * m네이버 - 비율은 맞는것 같지만 빠지는것들이 존재
   *
   *
   */
  Future<void> _printPdf() async {
    // setState(() async {
    // 하단 설정없이 프린터로 보내기 Printing.layoutPdf
    // final bytes = await _generatePdf(PdfPageFormat.a4, 'test');
    // await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => bytes);

    // html 문서 인쇄
    /**
       * https://smartall-mid-web-test.wjthinkbig.com/
       * https://www.wjthinkbig.com/
       *
       *
       * https://www.naver.com/
       * https://www.daum.net/
       *
       */
    // var urlStr = 'https://smartall-mid-web-test.wjthinkbig.com/';
    urlStr = (await _controller.currentUrl())!;
    QcLog.e("currentUrl === $urlStr");
    // final response = await http.get(Uri.parse(urlStr), headers: {'Access-Control-Allow-Origin': '*'});

    // final response = await http.get(Uri.parse(urlStr), headers: {'Access-Control-Allow-Origin': '*'});
    final response = await http.get(Uri.parse(urlStr));
    if (response.statusCode == 200) {
      final decodeData = utf8.decode(response.bodyBytes); // 한글 깨짐 인코딩
      QcLog.e("decodeData ====== " + decodeData);
      // await Printing.layoutPdf(onLayout: (PdfPageFormat format) => data.bodyBytes);
      // await Printing.layoutPdf(onLayout: (PdfPageFormat format) => data.bodyBytes);

      await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async => await Printing.convertHtml(
                // format: format.copyWith(marginLeft: 0, marginTop: 0, marginRight: 0, marginBottom: 0),
                format: PdfPageFormat.a4.copyWith(
                    height: PdfPageFormat.a4.height,
                    width: PdfPageFormat.a4.width,
                    marginBottom: 0,
                    marginLeft: 0,
                    marginRight: 0,
                    marginTop: 0),
                // html: response.body,
                html: decodeData,
              ));
    } else {
      QcLog.e("http.get failed");
    }

    // final response = await http.read(Uri.parse(urlStr), headers: {'Access-Control-Allow-Origin': '*'});
    // Print.e("response : $response");
    //
    // await Printing.layoutPdf(
    //     onLayout: (PdfPageFormat format) async => await Printing.convertHtml(
    //       format: format,
    //       html: response,
    //     ));
    // });
  }

  // flutter_html_to_pdf: ^0.7.0
  // Future<void> generateExampleDocument() async {
  //   /**
  //    * https://smartall-mid-web-test.wjthinkbig.com/
  //    * https://www.wjthinkbig.com/
  //    *
  //    *
  //    * https://www.naver.com/
  //    * https://www.daum.net/
  //    *
  //    */
  //   // var urlStr = 'https://www.naver.com/';
  //
  //   final data = await http.get(Uri.parse(urlStr));
  //   Print.e("data === " + data.body.toString());
  //
  //   // Directory tempDir = await DownloadsPathProvider.downloadsDirectory;
  //   // dir = await getExternalStorageDirectory();
  //   dir = await getExternalStorageDirectories(type: StorageDirectory.downloads);
  //   // final directory = await getApplicationDocumentsDirectory();
  //   // _path = directory.path;
  //
  //   var targetPath = dir?[0].path;
  //   Print.e("targetPath == " + targetPath!);
  //
  //   // var targetPat_ = await getExternalStorageDirectory();
  //   // targetPath = targetPat_?.path;
  //   // Print.e("targetPath == " + targetPath.toString());
  //
  //   final generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
  //       data.body.toString(), targetPath, targetFileName);
  //   var generatedPdfFilePath = generatedPdfFile.path;
  //
  //   //  /storage/emulated/0/Android/data/com.example.flutterex/files/Download/example-pdf.pdf
  //   // '/storage/emulated/0/Android/data/com.example.flutterex/files/Download/example-pdf'
  //   Print.e("generatedPdfFilePath == " + generatedPdfFilePath);
  // }

  final targetFileName = "example-pdf";

  Future<String?> get _localPath async {
    final directory =
        await getExternalStorageDirectories(type: StorageDirectory.downloads);
    // final directory = await getApplicationDocumentsDirectory();

    return directory?[0].path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    // return File('$path/counter.txt');
    return File('$path/$targetFileName');
  }

  Future<String> readCounter() async {
    QcLog.e("readCounter == ");
    try {
      final file = await _localFile;

      // 파일 읽기.
      String contents = await file.readAsString();
      QcLog.e("contents == " + contents);

      return contents;
    } catch (e) {
      QcLog.e("read error : $e");
      return "";
    }
  }

  Future<File> writeCounter(String counter) async {
    final file = await _localFile;

    // 파일 쓰기
    // return file.writeAsString('$counter');
    return file.writeAsString('$counter');
  }

  Future<void> geDirs() async {
    // Directory tempDir = await getTemporaryDirectory();
    // String tempPath = tempDir.path;
    //
    // Directory appDocDir = await getApplicationDocumentsDirectory();
    // String appDocPath = appDocDir.path;

    // /data/user/0/com.example.flutterex/cache
    var dir1 = await getTemporaryDirectory();
    QcLog.e("dir1 == " + dir1.toString());

    // /data/user/0/com.example.flutterex/app_flutter
    var dir2 = await getApplicationDocumentsDirectory();
    QcLog.e("dir2 == " + dir2.toString());

    // /data/user/0/com.example.flutterex/files
    var dir3 = await getApplicationSupportDirectory();
    QcLog.e("dir3 == " + dir3.toString());

    if (!Platform.isAndroid) {
      var dir4 = await getLibraryDirectory();
      QcLog.e("dir4 == " + dir4.toString());
    }

    // /storage/emulated/0/Android/data/com.example.flutterex/file
    var dir5 = await getExternalStorageDirectory();
    QcLog.e("dir5 == " + dir5.toString());

    // /storage/emulated/0/Android/data/com.example.flutterex/files/Download
    var dir6 =
        await getExternalStorageDirectories(type: StorageDirectory.downloads);
    QcLog.e("dir6 == " + dir6.toString());

    // /storage/emulated/0/Android/data/com.example.flutterex/cache
    var dir7 = await getExternalCacheDirectories();
    QcLog.e("dir7 == " + dir7.toString());

    var dir8 = await getDownloadsDirectory();
    QcLog.e("dir8 == " + dir8.toString());
  }
}

class MakePdfFromWeb extends StatelessWidget {
  const MakePdfFromWeb(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text(title)),
        // body: PdfPreview(
        //   build: (format) => _generatePdf(format, title),
        // ),
      ),
    );
  }
}

// class PDFSave extends StatefulWidget {
//
//   @override
//   _PDFSaveState createState() => _PDFSaveState();
// }
// class _PDFSaveState extends State<PDFSave> {
//
//   final pdf = pw.Document();
//   var anchor;
//
//   savePDF() async {
//     Uint8List pdfInBytes = await pdf.save();
//     final blob = html.Blob([pdfInBytes], 'application/pdf');
//     final url = html.Url.createObjectUrlFromBlob(blob);
//     anchor = html.document.createElement('a') as html.AnchorElement
//       ..href = url
//       ..style.display = 'none'
//       ..download = 'pdf.pdf';
//     html.document.body?.children.add(anchor);
//   }
//
//
//   createPDF() async {
//
//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) => pw.Column(
//           children: [
//             pw.Text('Hello World', style: pw.TextStyle(fontSize: 40)),
//           ],
//         ),
//       ),
//     );
//     savePDF();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     createPDF();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(backgroundColor: Colors.transparent,
//         appBar: AppBar(
//           title: Text('PDF Creator'),
//         ),
//         body: Center(
//             child:RaisedButton(
//               child: Text('Press'),
//               onPressed: () {
//                 anchor.click();
//                 Navigator.pop(context);
//               },
//             )
//         ));
//   }
// }

/**
 * PDF 뷰에 셋팅하고 하단에는 프린터 설정 등 보내기
 */
class PrintApp extends StatelessWidget {
  const PrintApp(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: PdfPreview(
          build: (format) => _generatePdf(format, title),
        ),
      ),
    );
  }

  /**
   * pdf 생성
   */
  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();
    final image = await imageFromAssetBundle('assets/splash_bg.png');

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text('Hello World'),
          ); // Center
        })); // Page

    //   pdf.addPage(pw.Page(
    // pageFormat: PdfPageFormat.a4,
    //       build: (pw.Context context) {
    //         return pw.Center(
    //           child: pw.Image(image),
    //         ); // Center
    //       })); // Page

    // pdf.addPage(
    //   pw.Page(
    //     pageFormat: format,
    //     build: (context) {
    //       return pw.Column(
    //         children: [
    //           pw.SizedBox(
    //             width: double.infinity,
    //             child: pw.FittedBox(
    //               child: pw.Text(title, style: pw.TextStyle(font: font)),
    //
    //
    //
    //             ),
    //           ),
    //           pw.SizedBox(height: 20),
    //           // pw.Flexible(child: pw.FlutterLogo())
    //         ],
    //       );
    //     },
    //   ),
    // );

    return pdf.save();
  }
}

///
///
///

class MyWebPdfApp extends StatefulWidget {
  @override
  _MyWebPdfApp createState() => _MyWebPdfApp();
}

class _MyWebPdfApp extends State<MyWebPdfApp> {
  late String generatedPdfFilePath;

  @override
  void initState() {
    super.initState();
    generateExampleDocument();
  }

  Future<void> generateExampleDocument() async {
    final htmlContent = """
    <!DOCTYPE html>
    <html>
      <head>
        <style>
        table, th, td {
          border: 1px solid black;
          border-collapse: collapse;
        }
        th, td, p {
          padding: 5px;
          text-align: left;
        }
        </style>
      </head>
      <body>
        <h2>PDF Generated with flutter_html_to_pdf plugin</h2>
        
        <table style="width:100%">
          <caption>Sample HTML Table</caption>
          <tr>
            <th>Month</th>
            <th>Savings</th>
          </tr>
          <tr>
            <td>January</td>
            <td>100</td>
          </tr>
          <tr>
            <td>February</td>
            <td>50</td>
          </tr>
        </table>
        
        <p>Image loaded from web</p>
        <img src="https://i.imgur.com/wxaJsXF.png" alt="web-img">
      </body>
    </html>
    """;

    Directory appDocDir = await getApplicationDocumentsDirectory();
    final targetPath = appDocDir.path;
    final targetFileName = "example-pdf";

    final generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
        htmlContent, targetPath, targetFileName);
    generatedPdfFilePath = generatedPdfFile.path;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          child: Text("Open Generated PDF Preview"),
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => PDFViewerScaffold(appBar: AppBar(title: Text("Generated PDF Document")), path: generatedPdfFilePath)),
            // );
          },
        ),
      ),
    ));
  }
}
