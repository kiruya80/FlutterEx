import 'package:flutterex/controllers/font_controller.dart';
import 'package:get/get.dart';

class FontBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FontController>(FontController());
  }
  
}