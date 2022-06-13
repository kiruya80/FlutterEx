import 'package:flutterex/controllers/hero_page_controller.dart';
import 'package:flutterex/controllers/tran_detail_page_controller.dart';
import 'package:flutterex/controllers/tran_page_controller.dart';
import 'package:get/get.dart';

class TranDetailPageBinding extends Bindings {
  @override
  void dependencies() {
    // Get.put<TranDetailPageController>(TranDetailPageController());
    Get.lazyPut(() => TranDetailPageController());
  }
}
