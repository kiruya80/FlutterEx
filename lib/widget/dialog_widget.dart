import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QcDialog {
  static showProgress({bool barrierDismissible = false}) async {
    dissmissProgress();

    Get.dialog(
      Loadding(),
      barrierDismissible: barrierDismissible,
      useSafeArea: true,
    );
  }

  static dissmissProgress() async {
    if (Get.isOverlaysOpen == true) {
      Get.back();
    }
  }
}

class Loadding extends StatelessWidget {
  Loadding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: CircularProgressIndicator()));
  }
}
