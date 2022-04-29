
import 'package:flutter/material.dart';
import 'package:flutterex/controllers/home_controller.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:get/get.dart';

/// 가이드 화면
class HomeScreen extends StatelessWidget {
  static const routeName = '/';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find<HomeController>();

    return Obx(() {
      return Scaffold(
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Print.e("onTap === ");
                    // writeCounter('파일 저장하기');
                  },
                  child:
                  Text(
                    'url변경 ' + controller.title.value,
                  ),
                ),

         ]   ),
          ),
        ),
      );
    });
  }
}
