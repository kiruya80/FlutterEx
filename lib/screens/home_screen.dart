import 'package:flutter/material.dart';
import 'package:flutterex/controllers/home_controller.dart';
import 'package:flutterex/datas/model/home_item.dart';
import 'package:flutterex/screens/components/home_list_item_card.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

/// 가이드 화면
class HomeScreen extends StatelessWidget {
  static const routeName = '/';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    HomeController controller = Get.find<HomeController>();

    controller.title.value = 'title_main'.tr;
    final screenWidth = MediaQuery.of(context).size.width;
    var orientation = MediaQuery.of(context).orientation;

    // return Obx(() {
    // return KeyboardWidget(
    return Scaffold(
      // Scaffold 기본 UI형태 appBar, body, BottomNavigationBar, FloatingActionButton, FloatingActionButtonLocation
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: QcText.headline6(controller.title.value),
      ),
      // SafeArea 디자인한 UI가 화면에 잘리지 않고 정상적으로 보이게
      body: SafeArea(
        // maintainBottomViewPadding 키보드가 올라온 경우 밀어낼지 덮을지 결정
        // maintainBottomViewPadding: false,
        child: Container(
            color: Theme.of(context).colorScheme.background,
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
                  // return Container(
                  // child: ListView.builder(
                  //   // shrinkWrap: true,
                  //   itemCount: items.length,
                  //   itemBuilder: (BuildContext context, int position) {
                  //     HomeItem item = items[position];
                  //     return Column(
                  //       children: <HomeListItemForm>[
                  //         HomeListItemForm(item: item),
                  //       ],
                  //     );
                  //   },
                  // ),

                  return Container(
                    child: GridView.builder(
                        /**
                       * SliverGridDelegateWithMaxCrossAxisExtent 반응형으로 너비로
                       * ㄴ maxCrossAxisExtent child에게 부여할 최대 width 지정
                       *
                       * SliverGridDelegateWithFixedCrossAxisCount 숫자로
                       * ㄴ crossAxisCount crossAxis 방향으로 몇개의 grid를 배치할 것인지 결정
                         *
                         * mainAxisExtent
                         * 주축에 있는 각 타일의 범위. 제공되는 경우 다음을 정의합니다.
                         * 주축의 각 타일이 차지하는 논리적 픽셀.
                         * null이면 [childAspectRatio]가 대신 사용됩니다.
                         *
                       */
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: orientation == Orientation.portrait
                              ? 2
                              : 3, //1 개의 행에 보여줄 item 개수
                          // mainAxisExtent: 256,
                          mainAxisSpacing: 10, //그리드 사이의 수직 간격
                          crossAxisSpacing: 10, // 그리드 사이의 좌우 간격
                          childAspectRatio: 1.5 / 1, //item 의 가로 1, 세로 2 의 비율
                        ),
                        // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        //   maxCrossAxisExtent: screenWidth / 4,
                        //   mainAxisExtent: 256,
                        //   mainAxisSpacing: 10, //그리드 사이의 수직 간격
                        //   crossAxisSpacing: 10, // 그리드 사이의 좌우 간격
                        //   childAspectRatio: 5 / 1, //item 의 가로 1, 세로 2 의 비율
                        // ),
                        itemCount: items.length,
                        itemBuilder: (context, position) {
                          HomeItem item = items[position];
                          // ClipRRect
                          // return Card (child: HomeListItemCardForm(item: item));

                          return HomeListItemCardForm(item: item);
                        }),
                  );

                  // return Flexible(
                  //   fit: FlexFit.tight,
                  //   child: GridView.builder(
                  //       /**
                  //      * SliverGridDelegateWithMaxCrossAxisExtent 반응형으로 너비로
                  //      * ㄴ maxCrossAxisExtent child에게 부여할 최대 width 지정
                  //      *
                  //      * SliverGridDelegateWithFixedCrossAxisCount 숫자로
                  //      * ㄴ crossAxisCount crossAxis 방향으로 몇개의 grid를 배치할 것인지 결정
                  //      */
                  //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //         crossAxisCount: orientation == Orientation.portrait
                  //             ? 2
                  //             : 3, //1 개의 행에 보여줄 item 개수
                  //         mainAxisExtent: 256,
                  //         mainAxisSpacing: 10, //그리드 사이의 수직 간격
                  //         crossAxisSpacing: 10, // 그리드 사이의 좌우 간격
                  //         childAspectRatio: 5 / 1, //item 의 가로 1, 세로 2 의 비율
                  //       ),
                  //       // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  //       //   maxCrossAxisExtent: screenWidth / 4,
                  //       //   mainAxisExtent: 256,
                  //       //   mainAxisSpacing: 10, //그리드 사이의 수직 간격
                  //       //   crossAxisSpacing: 10, // 그리드 사이의 좌우 간격
                  //       //   childAspectRatio: 5 / 1, //item 의 가로 1, 세로 2 의 비율
                  //       // ),
                  //       itemCount: items.length,
                  //       itemBuilder: (context, position) {
                  //         HomeItem item = items[position];
                  //         // ClipRRect
                  //         // return Card (child: HomeListItemCardForm(item: item));
                  //
                  //         return HomeListItemCardForm(item: item);
                  //       }),
                  // );
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
          Fluttertoast.cancel();
          Get.changeThemeMode(
            Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
          );
          Fluttertoast.showToast(
              msg: Get.isDarkMode ? 'theme_light'.tr : 'theme_dark'.tr,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1);
        },
        child: Icon(Icons.add),
      ), // This
    );
    // });
  }
}
