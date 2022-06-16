import 'package:flutterex/controllers/fire_database_controller.dart';
import 'package:get/get.dart';

class FireDatabaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FireDatabaseController>(FireDatabaseController());
  }
}
