import 'package:flutterex/controllers/app_controller.dart';
import 'package:flutterex/controllers/fire_msg_controller.dart';
import 'package:get/get.dart';

class FireMsgBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FireMsgController>(FireMsgController());
    Get.put<AppController>(AppController());
  }
}
