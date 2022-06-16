import 'package:flutterex/controllers/base_controller.dart';
import 'package:flutterex/datas/model/home_item.dart';
import 'package:flutterex/screens/dio_api_screen.dart';
import 'package:flutterex/screens/fire_analytics_screen.dart';
import 'package:flutterex/screens/fire_app_check_screen.dart';
import 'package:flutterex/screens/fire_auth_screen.dart';
import 'package:flutterex/screens/fire_crash_screen.dart';
import 'package:flutterex/screens/fire_database_screen.dart';
import 'package:flutterex/screens/fire_storage_screen.dart';
import 'package:flutterex/screens/font_screen.dart';
import 'package:flutterex/screens/http_api_screen.dart';
import 'package:flutterex/screens/image_screen.dart';
import 'package:flutterex/screens/loading_widget_screen.dart';
import 'package:flutterex/screens/multi_lang_screen.dart';
import 'package:flutterex/screens/permission_screen.dart';
import 'package:flutterex/screens/printing_screen.dart';
import 'package:flutterex/screens/fire_msg_screen.dart';
import 'package:flutterex/screens/tran_page_screen.dart';
import 'package:flutterex/screens/widget_type_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends BaseController {
  var _isDeviceLight = true.obs;

  get isDeviceLight => _isDeviceLight;
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

  Future<List<HomeItem>> getHomeItems() async {
    List<HomeItem> homeItems = [];

    homeItems.add(HomeItem(
        title: 'title_font'.tr, routeName: FontScreen.routeName, icon: ''));
    homeItems.add(HomeItem(
        title: 'title_multi_lang'.tr,
        routeName: MultiLangScreen.routeName,
        icon: ''));
    homeItems.add(HomeItem(
        title: 'title_widget'.tr,
        routeName: WidgetTypeScreen.routeName,
        icon: ''));
    homeItems.add(HomeItem(
        title: 'title_image'.tr, routeName: ImageScreen.routeName, icon: ''));
    homeItems.add(HomeItem(
        title: 'title_loading_widget'.tr,
        routeName: LoadingWidgetScreen.routeName,
        icon: ''));
    homeItems.add(HomeItem(
        title: 'title_tran'.tr, routeName: TranPageScreen.routeName, icon: ''));
    homeItems.add(HomeItem(
        title: 'title_permission'.tr,
        routeName: PermissionScreen.routeName,
        icon: ''));
    homeItems.add(HomeItem(
        title: 'title_web_print'.tr,
        routeName: PrintingScreen.routeName,
        icon: ''));
    homeItems.add(HomeItem(
        title: 'title_http_api'.tr,
        routeName: HttpApiScreen.routeName,
        icon: ''));
    homeItems.add(HomeItem(
        title: 'title_dio_api'.tr,
        routeName: DioApiScreen.routeName,
        icon: ''));

    /// firebase
    homeItems.add(HomeItem(
        title: 'title_firebase_auth'.tr,
        routeName: FireAuthScreen.routeName,
        icon: ''));
    homeItems.add(HomeItem(
        title: 'title_firebase_storage'.tr,
        routeName: FireStorageScreen.routeName,
        icon: ''));
    homeItems.add(HomeItem(
        title: 'title_firebase_database'.tr,
        routeName: FireDatabaseScreen.routeName,
        icon: ''));
    homeItems.add(HomeItem(
        title: 'title_firebase_messaging'.tr,
        routeName: FireMsgScreen.routeName,
        icon: ''));
    homeItems.add(HomeItem(
        title: 'title_firebase_app_check'.tr,
        routeName: FireAppCheckScreen.routeName,
        icon: ''));
    homeItems.add(HomeItem(
        title: 'title_firebase_crashlytics'.tr,
        routeName: FireCrashScreen.routeName,
        icon: ''));
    homeItems.add(HomeItem(
        title: 'title_firebase_analytics'.tr,
        routeName: FireAnalyticsScreen.routeName,
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
