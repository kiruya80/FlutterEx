import 'package:flutterex/bindings/dio_api_binding.dart';
import 'package:flutterex/bindings/fire_analytics_binding.dart';
import 'package:flutterex/bindings/fire_app_check_binding.dart';
import 'package:flutterex/bindings/fire_auth_binding.dart';
import 'package:flutterex/bindings/fire_crash_binding.dart';
import 'package:flutterex/bindings/fire_database_binding.dart';
import 'package:flutterex/bindings/fire_storage_binding.dart';
import 'package:flutterex/bindings/font_binding.dart';
import 'package:flutterex/bindings/hero_page_binding.dart';
import 'package:flutterex/bindings/home_binding.dart';
import 'package:flutterex/bindings/http_api_binding.dart';
import 'package:flutterex/bindings/image_binding.dart';
import 'package:flutterex/bindings/loading_widget_binding.dart';
import 'package:flutterex/bindings/multi_lang_binding.dart';
import 'package:flutterex/bindings/permission_binding.dart';
import 'package:flutterex/bindings/printing_binding.dart';
import 'package:flutterex/bindings/fire_msg_binding.dart';
import 'package:flutterex/bindings/tran_detail_page_binding.dart';
import 'package:flutterex/bindings/tran_page_binding.dart';
import 'package:flutterex/bindings/widget_type_binding.dart';
import 'package:flutterex/screens/dio_api_screen.dart';
import 'package:flutterex/screens/fire_analytics_screen.dart';
import 'package:flutterex/screens/fire_app_check_screen.dart';
import 'package:flutterex/screens/fire_auth_screen.dart';
import 'package:flutterex/screens/fire_crash_screen.dart';
import 'package:flutterex/screens/fire_database_screen.dart';
import 'package:flutterex/screens/fire_storage_screen.dart';
import 'package:flutterex/screens/font_screen.dart';
import 'package:flutterex/screens/hero_page_screen.dart';
import 'package:flutterex/screens/home_screen.dart';
import 'package:flutterex/screens/http_api_screen.dart';
import 'package:flutterex/screens/image_screen.dart';
import 'package:flutterex/screens/loading_widget_screen.dart';
import 'package:flutterex/screens/multi_lang_screen.dart';
import 'package:flutterex/screens/permission_screen.dart';
import 'package:flutterex/screens/printing_screen.dart';
import 'package:flutterex/screens/fire_msg_screen.dart';
import 'package:flutterex/screens/tran_detail_page_screen.dart';
import 'package:flutterex/screens/tran_page_screen.dart';
import 'package:get/get.dart';

import 'screens/widget_type_screen.dart';

class GetXRouterContainer {
  GetXRouterContainer() {
    // Get.put(SessionBinding());
  }

  final allPageRouter = [
    GetPage(
        name: HomeScreen.routeName,
        page: () => HomeScreen(),
        binding: HomeBinding()),
    GetPage(
      name: FontScreen.routeName,
      page: () => FontScreen(),
      binding: FontBinding(),
    ),
    GetPage(
      name: WidgetTypeScreen.routeName,
      page: () => WidgetTypeScreen(),
      binding: WidgetTypeBinding(),
    ),
    GetPage(
      name: ImageScreen.routeName,
      page: () => ImageScreen(),
      binding: ImageBinding(),
    ),
    GetPage(
      name: HeroPageScreen.routeName,
      page: () => HeroPageScreen(),
      binding: HeroPageBinding(),
    ),
    GetPage(
      name: TranPageScreen.routeName,
      page: () => TranPageScreen(),
      binding: TranPageBinding(),
    ),
    GetPage(
      name: TranDetailPageScreen.routeName,
      page: () => TranDetailPageScreen(title: ''),
      binding: TranDetailPageBinding(),
    ),
    GetPage(
      name: LoadingWidgetScreen.routeName,
      page: () => LoadingWidgetScreen(),
      binding: LoadingWidgetBinding(),
    ),
    GetPage(
      name: MultiLangScreen.routeName,
      page: () => MultiLangScreen(),
      binding: MultiLangBinding(),
    ),
    GetPage(
      name: PermissionScreen.routeName,
      page: () => PermissionScreen(),
      binding: PermissionBinding(),
    ),
    GetPage(
      name: PrintingScreen.routeName,
      page: () => PrintingScreen(),
      binding: PrintingWebviewBinding(),
    ),
    GetPage(
      name: HttpApiScreen.routeName,
      page: () => HttpApiScreen(),
      binding: HttpApiBinding(),
    ),
    GetPage(
      name: DioApiScreen.routeName,
      page: () => DioApiScreen(),
      binding: DioApiBinding(),
    ),

    /// firebase
    GetPage(
      name: FireAuthScreen.routeName,
      page: () => FireAuthScreen(),
      binding: FireAuthBinding(),
    ),
    GetPage(
      name: FireStorageScreen.routeName,
      page: () => FireStorageScreen(),
      binding: FireStorageBinding(),
    ),
    GetPage(
      name: FireDatabaseScreen.routeName,
      page: () => FireDatabaseScreen(),
      binding: FireDatabaseBinding(),
    ),
    GetPage(
      name: FireMsgScreen.routeName,
      page: () => FireMsgScreen(),
      binding: FireMsgBinding(),
    ),
    GetPage(
      name: FireAppCheckScreen.routeName,
      page: () => FireAppCheckScreen(),
      binding: FireAppCheckBinding(),
    ),
    GetPage(
      name: FireCrashScreen.routeName,
      page: () => FireCrashScreen(),
      binding: FireCrashBinding(),
    ),
    GetPage(
      name: FireAnalyticsScreen.routeName,
      page: () => FireAnalyticsScreen(),
      binding: FireAnalyticsBinding(),
    ),
  ];
}
