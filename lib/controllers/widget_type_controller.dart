import 'package:flutterex/utils/print_log.dart';
import 'package:get/get.dart';

class WidgetTypeController extends GetxController {
  var title = ''.obs;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    final name = args['name'];
    QcLog.e('name : $name');
    title.value = name;

    // title.value = 'multi_title'.tr;
  }
}
