import 'package:flutterex/controllers/fire_app_check_controller.dart';
import 'package:get/get.dart';

class FireAppCheckBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FireAppCheckController>(FireAppCheckController());
  }
}
