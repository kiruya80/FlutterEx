import 'package:flutterex/controllers/fire_crash_controller.dart';
import 'package:get/get.dart';

class FireCrashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FireCrashController>(FireCrashController());
  }
}
