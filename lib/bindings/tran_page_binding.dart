import 'package:flutterex/controllers/hero_page_controller.dart';
import 'package:flutterex/controllers/tran_page_controller.dart';
import 'package:get/get.dart';

class TranPageBinding extends Bindings {
  @override
  void dependencies() {
    // Get.put<TranPageController>(TranPageController());
    Get.lazyPut(() => TranPageController());
  }
}
