import 'package:flutterex/controllers/permission_controller.dart';
import 'package:get/get.dart';

class PermissionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PermissionController>(PermissionController());
  }
}
