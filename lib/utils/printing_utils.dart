import 'package:flutterex/utils/print_log.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';

class PrintingUtils {

  static void readDomFromJS(String html, String baseUrl, bool isLandscape) async {
    // String html = await _controller.evaluateJavascript("window.document.getElementsByTagName('html')[0].outerHTML;");
    // String html = await _controller.evaluateJavascript(
    //     "encodeURIComponent(document.documentElement.outerHTML)");
    QcLog.e("html ============== $html");
    QcLog.e("baseUrl ============== $baseUrl");
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
      // format: PdfPageFormat.a4.landscape,
        format: PdfPageFormat.a4.copyWith(
          // height: PdfPageFormat.a4.height,
          // width: PdfPageFormat.a4.width,
            height: PdfPageFormat.a4.width,
            width: PdfPageFormat.a4.height,
            marginBottom: 0,
            marginLeft: 0,
            marginRight: 0,
            marginTop: 0),
        // dynamicLayout : false,
        // usePrinterSettings : true,
        onLayout: (PdfPageFormat format) async => await Printing.convertHtml(
          // baseUrl: URI.HOST,
          baseUrl: baseUrl,
          // baseUrl: baseUrl,
          // format: PdfPageFormat.a4.landscape,
          format: PdfPageFormat.a4.copyWith(
            // height: PdfPageFormat.a4.height,
            // width: PdfPageFormat.a4.width,
              height: PdfPageFormat.a4.width,
              width: PdfPageFormat.a4.height,
              marginBottom: 0,
              marginLeft: 0,
              marginRight: 0,
              marginTop: 0),
          html: data,
        ));
  }
}