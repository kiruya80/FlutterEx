import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterex/controllers/fire_app_check_controller.dart';
import 'package:flutterex/controllers/fire_database_controller.dart';
import 'package:flutterex/controllers/fire_storage_controller.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:get/get.dart';

class FireAppCheckScreen extends StatelessWidget {
  static const routeName = '/fire/app/check';

  const FireAppCheckScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FireAppCheckController controller = Get.find<FireAppCheckController>();

    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: QcText.headline6(controller.title.value),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: SafeArea(
          // maintainBottomViewPadding 키보드가 올라온 경우 밀어낼지 덮을지 결정
          // maintainBottomViewPadding: false,
          child: Container(
              color: Theme.of(context).colorScheme.background,
              width: Get.width,
              height: Get.height,
              child: QcText.headline6(controller.title.value)),
        ),
      );
    });
  }
}
