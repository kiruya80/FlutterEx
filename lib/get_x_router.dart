import 'package:flutterex/bindings/dio_api_binding.dart';
import 'package:flutterex/bindings/font_binding.dart';
import 'package:flutterex/bindings/home_binding.dart';
import 'package:flutterex/bindings/http_api_binding.dart';
import 'package:flutterex/bindings/image_binding.dart';
import 'package:flutterex/bindings/loading_widget_binding.dart';
import 'package:flutterex/bindings/multi_lang_binding.dart';
import 'package:flutterex/bindings/permission_binding.dart';
import 'package:flutterex/bindings/printing_binding.dart';
import 'package:flutterex/bindings/push_binding.dart';
import 'package:flutterex/bindings/widget_type_binding.dart';
import 'package:flutterex/screens/dio_api_screen.dart';
import 'package:flutterex/screens/font_screen.dart';
import 'package:flutterex/screens/home_screen.dart';
import 'package:flutterex/screens/http_api_screen.dart';
import 'package:flutterex/screens/image_screen.dart';
import 'package:flutterex/screens/loading_widget_screen.dart';
import 'package:flutterex/screens/multi_lang_screen.dart';
import 'package:flutterex/screens/permission_screen.dart';
import 'package:flutterex/screens/printing_screen.dart';
import 'package:flutterex/screens/push_screen.dart';
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
        binding: FontBinding()),
    GetPage(
        name: WidgetTypeScreen.routeName,
        page: () => WidgetTypeScreen(),
        binding: WidgetTypeBinding()),
    GetPage(
        name: ImageScreen.routeName,
        page: () => ImageScreen(),
        binding: ImageBinding()),
    GetPage(
        name: LoadingWidgetScreen.routeName,
        page: () => LoadingWidgetScreen(),
        binding: LoadingWidgetBinding()),
    GetPage(
        name: MultiLangScreen.routeName,
        page: () => MultiLangScreen(),
        binding: MultiLangBinding()),
    GetPage(
        name: PermissionScreen.routeName,
        page: () => PermissionScreen(),
        binding: PermissionBinding()),
    GetPage(
        name: PrintingScreen.routeName,
        page: () => PrintingScreen(),
        binding: PrintingWebviewBinding()),
    GetPage(
        name: HttpApiScreen.routeName,
        page: () => HttpApiScreen(),
        binding: HttpApiBinding()),
    GetPage(
        name: DioApiScreen.routeName,
        page: () => DioApiScreen(),
        binding: DioApiBinding()),
    GetPage(
        name: PushScreen.routeName,
        page: () => PushScreen(),
        binding: PushBinding()),
  ];
}
