import 'package:flutter/material.dart';
import 'package:flutterex/controllers/home_controller.dart';
import 'package:flutterex/datas/model/home_item.dart';
import 'package:flutterex/screens/components/home_list_item.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:get/get.dart';

/// 가이드 화면
class HomeScreen extends StatelessWidget {
  static const routeName = '/';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Print.e("HomeScreen =============");
    HomeController controller = Get.find<HomeController>();

    controller.title.value = 'title_main'.tr;

    // return Obx(() {
    // return KeyboardWidget(
    return Scaffold(
      // Scaffold 기본 UI형태 appBar, body, BottomNavigationBar, FloatingActionButton, FloatingActionButtonLocation
      appBar: AppBar(
        title:
            QcText.headline6(controller.title.value, fontColor: Colors.white),
      ),
      // SafeArea 디자인한 UI가 화면에 잘리지 않고 정상적으로 보이게
      body: SafeArea(
        // maintainBottomViewPadding 키보드가 올라온 경우 밀어낼지 덮을지 결정
        // maintainBottomViewPadding: false,
        child: Container(
            color: Colors.white,
            width: Get.width,
            height: Get.height,
            child: FutureBuilder<List<HomeItem>>(
              future: controller.getHomeItems(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<HomeItem>> snapshot) {
                //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
                if (snapshot.hasData == false) {
                  return Container(
                      child: Center(child: CircularProgressIndicator()));
                } else if (snapshot.hasError) {
                  return Container(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.white),
                    ),
                  ));
                } else {
                  List<HomeItem> items = snapshot.data!;
                  return Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int position) {
                        HomeItem item = items[position];

                        return Column(
                          children: <HomeListItemForm>[
                            HomeListItemForm(item: item),
                          ],
                        );
                      },
                    ),
                  );
                }
              },
            )),
      ),
      floatingActionButton: FloatingActionButton(
        // tooltip: 'Increment',
        onPressed: () {
          // Get.changeTheme(
          //   Get.isDarkMode ? ThemeData.light() : ThemeData.dark(),
          // );
          // 이걸로 해야 머터리얼3 디자인 테마 변경 가능
          Get.changeThemeMode(
            Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
          );
        },
        child: Icon(Icons.add),
      ), // This
    );
    // });
  }
}
