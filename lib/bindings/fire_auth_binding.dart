import 'package:flutterex/controllers/fire_auth_controller.dart';
import 'package:get/get.dart';

class FireAuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FireAuthController>(FireAuthController());
  }
}
