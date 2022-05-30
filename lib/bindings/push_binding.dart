import 'package:flutterex/controllers/push_controller.dart';
import 'package:get/get.dart';

class PushBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PushController>(PushController());
  }
}
