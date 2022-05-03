import 'package:flutterex/controllers/printing_controller.dart';
import 'package:get/get.dart';

class PrintingWebviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PrintingController>(PrintingController());
  }
}
