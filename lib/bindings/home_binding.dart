import 'package:flutterex/controllers/app_controller.dart';
import 'package:flutterex/controllers/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AppController>(AppController());
    Get.put<HomeController>(HomeController());
  }
}
