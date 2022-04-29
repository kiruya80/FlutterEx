import 'package:flutter/material.dart';
import 'package:flutterex/get_x_router.dart';
import 'package:flutterex/screens/home_screen.dart';
import 'package:get/get.dart';

import 'package:flutter/foundation.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await GetStorage.init();
  // await Firebase.initializeApp();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!
        );
      },

      // navigatorObservers: [MiddleNavObserver.instance],
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
    );
  }
}