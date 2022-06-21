import 'package:flutter/material.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:get/get.dart';

enum DialogBtn { LEFT, RIGHT }

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

  static void showMsg({String? title, required String msg, Function? callback}) {
    show(
        title: title,
        content: QcText.bodyText1('$msg'),
        rBtnStr: 'ok'.tr,
        callback: callback);
  }

  static void showMsgTwoBtn(
      {String? title,
      required Widget content,
      String? lBtnStr,
      String? rBtnStr,
      Function? callback}) {
    show(
        title: title,
        content: content,
        lBtnStr: lBtnStr,
        rBtnStr: rBtnStr,
        callback: callback);
  }

  static void show(
      {String? title,
      required Widget content,
      String? lBtnStr,
      String? rBtnStr,
      Function? callback}) {
    double gWidth = (Get.width / 3);
    double gHeight = (Get.height / 3);
    double gHeightMin = gHeight / 3;

    if (Get.width >= Get.height) {
      gWidth = (Get.width / 3);
      gHeight = (Get.height / 3);
      gHeightMin = gHeight / 3;
    } else {
      gWidth = (Get.width / 2);
      gHeight = (Get.height / 4);
      gHeightMin = gHeight / 3;
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
            child: content,
          ),
        ),
        actions: <Widget>[
          Visibility(
            visible: lBtnStr != null && lBtnStr.isNotEmpty,
            child: TextButton(
              child: QcText.button(
                lBtnStr ?? 'cancel'.tr,
                // fontWeight: FontWeight.bold,
                fontColor: Theme.of(Get.overlayContext!).colorScheme.secondary,
              ),
              onPressed: () {
                Get.back();
                callback?.call(DialogBtn.LEFT);
              },
            ),
          ),
          TextButton(
            child: QcText.button(
              rBtnStr ?? 'ok'.tr,
              // fontColor: Theme.of(Get.overlayContext!).colorScheme.primary,
            ),
            onPressed: () {
              Get.back();
              callback?.call(DialogBtn.RIGHT);
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
