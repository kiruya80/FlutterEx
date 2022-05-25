import 'package:flutterex/controllers/loading_widget_controller.dart';
import 'package:get/get.dart';

class LoadingWidgetBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoadingWidgetController>(LoadingWidgetController());
  }
}
