import 'package:flutter/widgets.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:get/get.dart';

class PrintingController extends GetxController {
  var title = "Printing Web Sample".obs;
  var webviewUrl = "https://www.naver.com/".obs;

  final formKey = GlobalKey<FormState>();

  var url = "".obs;

  void setUrl() {}
  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    final name = args['name'];
    Print.e('name : $name');
    title.value = name;

  }

  bool? isTextValidate() {
    return formKey.currentState?.validate();
  }

  void saveTextValidate() {
    return formKey.currentState?.save();
  }

  String makeUrl(String url) {
    String _url = '';
    if (url == null || url.isEmpty) {
      return _url;
    }

    if (!url.startsWith('https://') || !url.startsWith('http://')) {
      url = url.replaceAll('https://', '');
      url = url.replaceAll('http://', '');
      _url = 'https://' + url;
    }
    bool _validURL = Uri.parse(_url).isAbsolute;
    var host = Uri.parse(_url).host;
    Print.e("host  : $host");

    if (_validURL) {
      return _url;
    } else {
      return '';
    }
  }
}
