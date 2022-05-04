import 'package:flutter/material.dart';
import 'package:flutterex/controllers/permission_controller.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionScreen extends StatelessWidget {
  static const routeName = '/permission';

  const PermissionScreen({Key? key}) : super(key: key);

  Future<bool> requestPermission() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();
    return cameraPermission.isGranted == true &&
        micPermission.isGranted == true;
  }

  // Future<bool> checkAccessibilityPermissions() async {
  //   return await AndroidChannel.platform
  //       .invokeMethod('checkAccessibilityPermissions');
  // }

  void doCheckPermission() async {
    await [
      Permission.camera,
      Permission.storage,
      Permission.microphone,
      // Permission.manageExternalStorage,
    ].request();
  }

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
        child: OutlinedButton(
            onPressed: () async {
              doCheckPermission();
            },
            style: OutlinedButton.styleFrom(
              minimumSize: Size.fromHeight(80),
              primary: Colors.teal,
              backgroundColor: Colors.white,
            ),
            child: QcText.subtitle1('권한부여')),
      ),
    );
    // });
  }
}
