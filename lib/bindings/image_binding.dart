import 'package:flutterex/controllers/image_controller.dart';
import 'package:flutterex/controllers/loading_widget_controller.dart';
import 'package:get/get.dart';

class ImageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ImageController>(ImageController());
  }
}
