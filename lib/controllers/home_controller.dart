import 'package:flutterex/utils/print_log.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var title = "".obs;

  @override
  void onInit() {
    super.onInit();

    // ever(guideType, (_) {
    //   reqGuideInfo();
    // });
  }

  @override
  void onClose() {
    Print.e("onClose");
  }
}