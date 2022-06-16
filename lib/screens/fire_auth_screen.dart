import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterex/controllers/fire_auth_controller.dart';
import 'package:flutterex/controllers/fire_storage_controller.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:get/get.dart';

///
/// 이메일, 익명
///
/// 구글, 애플, 페이스북,
/// 카카오
///
/// https://sudarlife.tistory.com/entry/flutter-firebase-auth-%ED%94%8C%EB%9F%AC%ED%84%B0-%ED%8C%8C%EC%9D%B4%EC%96%B4%EB%B2%A0%EC%9D%B4%EC%8A%A4-%EC%97%B0%EB%8F%99-%EB%A1%9C%EA%B7%B8%EC%9D%B8%EC%9D%84-%EA%B5%AC%EC%97%B0%ED%95%B4%EB%B3%B4%EC%9E%90-part-1?category=1176193
///
class FireAuthScreen extends StatelessWidget {
  static const routeName = '/fire/auth';

  const FireAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FireAuthController controller = Get.find<FireAuthController>();

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
