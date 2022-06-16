import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterex/controllers/fire_storage_controller.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:get/get.dart';

/// https://eunjin3786.tistory.com/280
///
///
/// https://sudarlife.tistory.com/entry/Flutter-%ED%94%8C%EB%9F%AC%ED%84%B0-%EC%82%BD%EC%A7%88%EC%9D%80-%EA%B7%B8%EB%A7%8C-Firebase-Messaging-iOS-%EC%85%8B%EC%97%85
/// https://babbab2.tistory.com/58?category=831129
///
///
class FireStorageScreen extends StatelessWidget {
  static const routeName = '/fire/storage';

  const FireStorageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FireStorageController controller = Get.find<FireStorageController>();

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
