import 'package:flutter/material.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:flutterex/widget/text_widget.dart';
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

  static void showMsg(String? title, var msg) {
    QcLog.e('showMsg : $msg');

    double gWidth = (Get.width / 3);
    double gHeight = (Get.height / 3);
    double gHeightMin = gHeight / 3;

    if (Get.width >= Get.height) {
      QcLog.e('가로 ========');
      gWidth = (Get.width / 3);
      gHeight = (Get.height / 3);
      gHeightMin = gHeight / 3;
      QcLog.e(
          'gWidth : $gWidth , gHeight : $gHeight , gHeightMin : $gHeightMin');
    } else {
      QcLog.e('세로 ========');
      gWidth = (Get.width / 2);
      gHeight = (Get.height / 4);
      gHeightMin = gHeight / 3;
      QcLog.e(
          'gWidth : $gWidth , gHeight : $gHeight , gHeightMin : $gHeightMin');
    }

    Get.dialog(
      AlertDialog(
        title: Text(title ?? 'notice'.tr),
        content: Container(
          constraints: BoxConstraints(
              minHeight: gHeightMin,
              minWidth: gWidth,
              maxHeight: gHeight,
              maxWidth: gWidth),
          child: SingleChildScrollView(
            // child: ListBody(
            //   children: <Widget>[
            //     Text('$msg'),
            //   ],
            // ),
            // child: Text('$msg'),
            child: QcText.bodyText1('$msg'),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('close'.tr),
            // child: QcText.bodyText1('닫기'),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
    );
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
