import 'dart:ffi';

import 'package:flutterex/datas/model/home_item.dart';
import 'package:flutterex/screens/font_screen.dart';
import 'package:flutterex/screens/permission_screen.dart';
import 'package:flutterex/screens/printing_screen.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var title = "타이틀".obs;
  List<String> languages = [];
  List<String> languages1 = <String>[].obs;
  final _subMenu = <Object>[].obs;

  RxList<Object> get subMenu => _subMenu;

  // var list_3 = [1, 2, 3, 4];
  // var list_4 = [];

// final name = RxString('');
// final isLogged = RxBool(false);
// final count = RxInt(0);
// final balance = RxDouble(0.0);
// final items = RxList<String>([]);
// final myMap = RxMap<String, int>({});
//
// final name1 = Rx<String>('');
// final isLogged1 = Rx<Bool>(false);
// final count1 = Rx<int>(0);
// final balance1 = Rx<Double>(0.0);
// final number1 = Rx<Num>(0);
// final items1 = Rx<List<String>>([]);
// final myMap1 = Rx<Map<String, int>>({});
//
// // 커스텀 클래스 - 그 어떤 클래스도 가능합니다
// final user = Rx<User>();
//
// final name = ''.obs;
// final isLogged = false.obs;
// final count = 0.obs;
// final balance = 0.0.obs;
// final number = 0.obs;
// final items = <String>[].obs;
// final myMap = <String, int>{}.obs;

  @override
  void onInit() {
    super.onInit();

    // ever(guideType, (_) {
    //   reqGuideInfo();
    // });
  }

  Future<List<HomeItem>> getHomeItems() async {
    List<HomeItem> homeItems = [];

    homeItems.add(
        new HomeItem(name: 'Font', routeName: FontScreen.routeName, icon: ''));
    homeItems.add(new HomeItem(
        name: 'Permission', routeName: PermissionScreen.routeName, icon: ''));
    homeItems.add(new HomeItem(
        name: 'Web Print', routeName: PrintingScreen.routeName, icon: ''));

    return homeItems;
  }
}
