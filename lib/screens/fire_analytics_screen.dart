import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterex/controllers/fire_analytics_controller.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:get/get.dart';

class FireAnalyticsScreen extends StatelessWidget {
  static const routeName = '/fire/analytics';

  const FireAnalyticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FireAnalyticsController controller = Get.find<FireAnalyticsController>();

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
              child: QcText.headline6('push')),
        ),
      );
    });
  }
}
