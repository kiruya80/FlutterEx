import 'package:flutter/material.dart';
import 'package:flutterex/get_x_router.dart';
import 'package:flutterex/langs/Languages.dart';
import 'package:flutterex/screens/home_screen.dart';
import 'package:get/get.dart';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await GetStorage.init();
  // await Firebase.initializeApp();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _prefs = SharedPreferences.getInstance();

  Future<void> samplePref() async {
    final SharedPreferences prefs = await _prefs;

    var blockAppList = prefs.getString('SETTING_CHILD_MANAGEMENT_BLOCKS') ??
        'DEFAULT_BLOCK_PACKAGES';
    prefs.setString(
        'SETTING_CHILD_MANAGEMENT_BLOCKS', 'SETTING_CHILD_MANAGEMENT_BLOCKS');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: GetMaterialApp(
          builder: (BuildContext context, Widget? child) {
            return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child!);
          },

          // localizationsDelegates: context.localizationDelegates,
          // supportedLocales: context.supportedLocales,

          translations: Languages(),
          locale: Get.deviceLocale,
          fallbackLocale: const Locale('ko', 'KR'),

          smartManagement: SmartManagement.keepFactory,
          debugShowCheckedModeBanner: kDebugMode,
          title: "Flutter Sample",
          getPages: GetXRouterContainer().allPageRouter,
          initialRoute: HomeScreen.routeName,

          // theme: Themes.darkTheme,
          // darkTheme: Themes.darkTheme,
          // themeMode: ThemeService().theme,
        ));
  }
}
