import 'package:flutterex/controllers/dio_api_controller.dart';
import 'package:get/get.dart';

class DioApiBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DioApiController>(DioApiController());
  }
}
