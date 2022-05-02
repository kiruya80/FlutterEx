import 'package:flutter/material.dart';
import 'package:flutterex/controllers/home_controller.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

/// 가이드 화면
class HomeScreen extends StatelessWidget {
  static const routeName = '/';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find<HomeController>();

    return Obx(() {
      // return KeyboardWidget(
      return Scaffold(
        // Scaffold 기본 UI형태 appBar, body, BottomNavigationBar, FloatingActionButton, FloatingActionButtonLocation
        appBar: AppBar(
          title: Text('Flutter Sample'),
        ),
        // SafeArea 디자인한 UI가 화면에 잘리지 않고 정상적으로 보이게
        body: SafeArea(
          top: true,
          bottom: true,
          right: true,
          left: false,
          // maintainBottomViewPadding 키보드가 올라온 경우 밀어낼지 덮을지 결정
          maintainBottomViewPadding: false,
          child: Container(
            color: Colors.white,
            width: Get.width,
            height: Get.height,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Print.e("onTap === ");
                      // writeCounter('파일 저장하기');
                      controller.title.value = "test";
                    },
                    child: Text('url변경 ${controller.title.value}'),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Print.e("onTap === ");
                      // writeCounter('파일 저장하기');
                      controller.title.value = "test";
                    },
                    child: Text('url변경 ${controller.title.value}'),
                  ),
                ]),
          ),
        ),
      );
    });
  }
}
