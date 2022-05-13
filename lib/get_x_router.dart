import 'package:flutterex/bindings/font_binding.dart';
import 'package:flutterex/bindings/home_binding.dart';
import 'package:flutterex/bindings/http_api_binding.dart';
import 'package:flutterex/bindings/multi_lang_binding.dart';
import 'package:flutterex/bindings/permission_binding.dart';
import 'package:flutterex/bindings/printing_binding.dart';
import 'package:flutterex/bindings/widget_type_binding.dart';
import 'package:flutterex/screens/font_screen.dart';
import 'package:flutterex/screens/home_screen.dart';
import 'package:flutterex/screens/http_api_screen.dart';
import 'package:flutterex/screens/multi_lang_screen.dart';
import 'package:flutterex/screens/permission_screen.dart';
import 'package:flutterex/screens/printing_screen.dart';
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
        binding: widgetTypeBinding()),
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
  ];
}
