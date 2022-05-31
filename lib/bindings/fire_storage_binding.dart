import 'package:flutterex/controllers/fire_storage_controller.dart';
import 'package:get/get.dart';

class FireStorageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FireStorageController>(FireStorageController());
  }
}
