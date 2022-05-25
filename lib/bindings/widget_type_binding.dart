import 'package:flutterex/controllers/widget_type_controller.dart';
import 'package:get/get.dart';

class WidgetTypeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<WidgetTypeController>(WidgetTypeController());
  }
}
