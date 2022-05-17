import 'package:flutter/material.dart';
import 'package:flutterex/controllers/permission_controller.dart';
import 'package:flutterex/screens/components/permission_list_item.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:get/get.dart';

class PermissionScreen extends StatelessWidget {
  static const routeName = '/permission';

  const PermissionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QcLog.e("PermissionScreen =============");
    PermissionController controller = Get.find<PermissionController>();

    return Obx(() {
      // return KeyboardWidget(
      return Scaffold(
        // Scaffold 기본 UI형태 appBar, body, BottomNavigationBar, FloatingActionButton, FloatingActionButtonLocation
        appBar: AppBar(
          title: QcText.headline6(
            controller.title.value,
            fontColor: Colors.white,
          ),
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
              color: Theme.of(context).colorScheme.background,
              width: Get.width,
              height: Get.height,
              child:
                  // FutureBuilder<List<PermissionItem>>(
                  //   future: controller.getPermissionItems(),
                  //   builder: (BuildContext context,
                  //       AsyncSnapshot<List<PermissionItem>> snapshot) {
                  //     //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
                  //     if (snapshot.hasData == false) {
                  //       return Container(
                  //           child: Center(child: CircularProgressIndicator()));
                  //     } else if (snapshot.hasError) {
                  //       return Container(
                  //           child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Text(
                  //           'Error: ${snapshot.error}',
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .bodyText1!
                  //               .copyWith(color: Colors.white),
                  //         ),
                  //       ));
                  //     } else {
                  //       List<PermissionItem> items = snapshot.data!;
                  //       return Container(
                  //         child: ListView.builder(
                  //           shrinkWrap: true,
                  //           itemCount: items.length,
                  //           itemBuilder: (BuildContext context, int position) {
                  //             PermissionItem item = items[position];
                  //
                  //             return Column(
                  //               children: <PermissionListItemForm>[
                  //                 PermissionListItemForm(
                  //                     position: position,
                  //                     item: item,
                  //                     // callback: requestPermission(item.permission)
                  //                     callback: (value) {
                  //                       requestPermission(value);
                  //                     }),
                  //               ],
                  //             );
                  //           },
                  //         ),
                  //       );
                  //     }
                  //   },
                  // )
                  Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.permissionList.value.length,
                  itemBuilder: (BuildContext context, int position) {
                    var item = controller.permissionList.value[position];

                    return Column(
                      children: <PermissionListItemForm>[
                        PermissionListItemForm(
                            position: position,
                            item: item,
                            // callback: requestPermission(item.permission)
                            callback: (value) {}),
                      ],
                    );
                  },
                ),
              )),
        ),
      );
    });
  }
}

// requestPermission(Permission permission) {
// }
