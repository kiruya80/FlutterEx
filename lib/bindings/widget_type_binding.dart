import 'package:flutterex/controllers/widget_type_controller.dart';
import 'package:get/get.dart';

class widgetTypeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<WidgetTypeController>(WidgetTypeController());
  }
}
