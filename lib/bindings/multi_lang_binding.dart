import 'package:flutterex/controllers/font_controller.dart';
import 'package:flutterex/controllers/multi_lang_controller.dart';
import 'package:get/get.dart';

class MultiLangBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MultiLangController>(MultiLangController());
  }
  
}