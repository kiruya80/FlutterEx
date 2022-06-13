import 'package:flutterex/controllers/hero_page_controller.dart';
import 'package:get/get.dart';

class HeroPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HeroPageController>(HeroPageController());
  }
}
