import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QcDialog {
  static showProgress(
      {double size = 160.0, bool barrierDismissible = false}) async {
    dissmissProgress();

    Get.dialog(
      // MidCircularProgress(size: size),
      CircularProgressIndicator(),
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
