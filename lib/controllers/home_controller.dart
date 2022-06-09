import 'package:flutter/widgets.dart';
import 'package:flutterex/datas/model/home_item.dart';
import 'package:flutterex/screens/dio_api_screen.dart';
import 'package:flutterex/screens/fire_analytics_screen.dart';
import 'package:flutterex/screens/fire_crash_screen.dart';
import 'package:flutterex/screens/fire_storage_screen.dart';
import 'package:flutterex/screens/font_screen.dart';
import 'package:flutterex/screens/http_api_screen.dart';
import 'package:flutterex/screens/image_screen.dart';
import 'package:flutterex/screens/loading_widget_screen.dart';
import 'package:flutterex/screens/multi_lang_screen.dart';
import 'package:flutterex/screens/permission_screen.dart';
import 'package:flutterex/screens/printing_screen.dart';
import 'package:flutterex/screens/fire_msg_screen.dart';
import 'package:flutterex/screens/widget_type_screen.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController with WidgetsBindingObserver {
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

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance?.addObserver(this);
  // }
  //

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  /**
   * 이프 사이클 종류

      resumed: 앱이 화면에 다시 보이기 시작하는 경우, 유저의 인풋에 반응할 수 있다.
      inactive: 앱이 비활성화되고 유저의 인풋에 반응할 수 없다.
      paused: 앱이 유저에게 보이지 않고, 유저의 인풋에 반응할 수 없으며 백그라운드로 동작한다. (보통 inactive 이후 실행)
      detached(suspending): 모든 뷰가 제거되고 플러터 엔진만 동작 중이며 앱이 종료되기 직전에 실행된다.
      해당 상황은 앱을 스와이프로 제거하거나, 배터리가 부족해서 종료될 때, 메모리 부족으로 스왑될 경우 동작한다. 이 경우 보통 100%의 관찰을 보장하지 않는다.
   */
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    QcLog.e('didChangeAppLifecycleState : $state');
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.paused:
        break;
    }
  }

  Future<List<HomeItem>> getHomeItems() async {
    List<HomeItem> homeItems = [];

    homeItems.add(new HomeItem(
        name: 'title_font'.tr, routeName: FontScreen.routeName, icon: ''));
    homeItems.add(new HomeItem(
        name: 'title_multi_lang'.tr,
        routeName: MultiLangScreen.routeName,
        icon: ''));
    homeItems.add(new HomeItem(
        name: 'title_widget'.tr,
        routeName: WidgetTypeScreen.routeName,
        icon: ''));
    homeItems.add(new HomeItem(
        name: 'title_image'.tr, routeName: ImageScreen.routeName, icon: ''));
    homeItems.add(new HomeItem(
        name: 'title_loading_widget'.tr,
        routeName: LoadingWidgetScreen.routeName,
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
        name: 'title_http_api'.tr,
        routeName: HttpApiScreen.routeName,
        icon: ''));
    homeItems.add(new HomeItem(
        name: 'title_dio_api'.tr, routeName: DioApiScreen.routeName, icon: ''));
    homeItems.add(new HomeItem(
        name: 'title_firebase_crashlytics'.tr,
        routeName: FireCrashScreen.routeName,
        icon: ''));
    homeItems.add(new HomeItem(
        name: 'title_firebase_analytics'.tr,
        routeName: FireAnalyticsScreen.routeName,
        icon: ''));
    homeItems.add(new HomeItem(
        name: 'title_firebase_storage'.tr,
        routeName: FireStorageScreen.routeName,
        icon: ''));
    homeItems.add(new HomeItem(
        name: 'title_firebase_messaging'.tr,
        routeName: FireMsgScreen.routeName,
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
