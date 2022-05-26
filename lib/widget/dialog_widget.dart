import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animations/loading_animations.dart';

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
    return Container(
        child: Center(child: CircularProgressIndicator()
            //     LoadingFilling.square(
            //   duration: Duration(milliseconds: 2400),
            //   borderColor: Theme.of(context).colorScheme.secondary,
            //   fillingColor: Theme.of(context).colorScheme.primary,
            // ),

            //     LoadingBouncingLine.circle(
            //   duration: Duration(milliseconds: 1400),
            //   backgroundColor: Theme.of(context).colorScheme.primary,
            // ),
            ));
  }
}
