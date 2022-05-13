import 'package:flutterex/controllers/http_api_controller.dart';
import 'package:get/get.dart';

class HttpApiBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HttpApiController>(HttpApiController());
  }
}
