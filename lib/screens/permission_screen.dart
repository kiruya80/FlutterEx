import 'package:flutter/material.dart';
import 'package:flutterex/controllers/permission_controller.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:get/get.dart';

class PermissionScreen extends StatelessWidget {
  static const routeName = '/permission';

  const PermissionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Print.e("PermissionScreen =============");
    PermissionController controller = Get.find<PermissionController>();

    // return Obx(() {
    // return KeyboardWidget(
    return Scaffold(
      // Scaffold 기본 UI형태 appBar, body, BottomNavigationBar, FloatingActionButton, FloatingActionButtonLocation
      appBar: AppBar(
        title: QcText.subtitle1(controller.title.value),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      // SafeArea 디자인한 UI가 화면에 잘리지 않고 정상적으로 보이게
      body: SafeArea(
        // maintainBottomViewPadding 키보드가 올라온 경우 밀어낼지 덮을지 결정
        // maintainBottomViewPadding: false,
        child: Container(
            color: Colors.white,
            width: Get.width,
            height: Get.height,
            child: QcText.subtitle1('PermissionScreen')),
      ),
    );
    // });
  }
}
