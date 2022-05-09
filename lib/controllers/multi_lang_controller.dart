import 'package:flutterex/utils/print_log.dart';
import 'package:get/get.dart';

class MultiLangController extends GetxController {
  var title = ''.obs;
  var lang = "ko".obs;

  @override
  void onInit() {
    super.onInit();
    Print.e("onInit ");
    // title.value = 'multi_title'.tr;
  }
}
