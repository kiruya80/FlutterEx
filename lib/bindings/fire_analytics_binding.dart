import 'package:flutterex/controllers/fire_analytics_controller.dart';
import 'package:get/get.dart';

class FireAnalyticsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FireAnalyticsController>(FireAnalyticsController());
  }
}
