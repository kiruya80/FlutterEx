import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutterex/datas/model/home_item.dart';
import 'package:flutterex/screens/font_screen.dart';
import 'package:flutterex/screens/http_api_screen.dart';
import 'package:flutterex/screens/multi_lang_screen.dart';
import 'package:flutterex/screens/permission_screen.dart';
import 'package:flutterex/screens/printing_screen.dart';
import 'package:flutterex/screens/widget_type_screen.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  var _isDeviceLight = true.obs;

  get isDeviceLight => _isDeviceLight;
  var title = "".obs;
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

    // final args = Get.arguments;
    // final name = args['name'];
    // Print.e('name : $name');
    // title.value = name;

    // ever(guideType, (_) {
    //   reqGuideInfo();
    // });
  }

  Future<List<HomeItem>> getHomeItems() async {
    List<HomeItem> homeItems = [];

    homeItems.add(new HomeItem(
        name: 'title_font'.tr, routeName: FontScreen.routeName, icon: ''));
    homeItems.add(new HomeItem(
        name: 'title_widget'.tr,
        routeName: WidgetTypeScreen.routeName,
        icon: ''));
    homeItems.add(new HomeItem(
        name: 'title_multi_lang'.tr,
        routeName: MultiLangScreen.routeName,
        icon: ''));
    homeItems.add(new HomeItem(
        name: 'title_permission'.tr,
        routeName: PermissionScreen.routeName,
        icon: ''));
    homeItems.add(new HomeItem(
        name: 'title_web_print'.tr,
        routeName: PrintingScreen.routeName,
        icon: ''));
    homeItems.add(new HomeItem(
        name: 'HttpApiScreen'.tr,
        routeName: HttpApiScreen.routeName,
        icon: ''));

    return homeItems;
  }

  final _prefs = SharedPreferences.getInstance();

  Future<void> samplePref() async {
    final SharedPreferences prefs = await _prefs;

    var blockAppList = prefs.getBool('APP_THEME') ?? false;
    prefs.setString(
        'SETTING_CHILD_MANAGEMENT_BLOCKS', 'SETTING_CHILD_MANAGEMENT_BLOCKS');
  }
}
