import 'package:flutter/material.dart';
import 'package:flutterex/constants/constant.dart';
import 'package:flutterex/get_x_router.dart';
import 'package:flutterex/langs/languages.dart';
import 'package:flutterex/screens/home_screen.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await GetStorage.init();
  // await Firebase.initializeApp();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

  getDeviceTheme();

  runApp(MyApp());
}

Future<void> getDeviceTheme() async {
  final isDeviceLight =
      SchedulerBinding.instance.window.platformBrightness == Brightness.light;
  QcLog.e(
      'Device Theme : $isDeviceLight  , ${isDeviceLight ? 'theme_light'.tr : 'theme_dark'.tr}');

  Get.changeThemeMode(isDeviceLight ? ThemeMode.light : ThemeMode.dark);

  Fluttertoast.showToast(
      msg: Get.isDarkMode ? 'theme_light'.tr : 'theme_dark'.tr,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();

    // var seedColorScheme = ColorScheme.fromSeed(seedColor: Colors.green);
    // seedColorScheme.secondary
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

          darkTheme: ThemeData(
            useMaterial3: true,
            // primaryColor: Colors.purple[800],
            // colorScheme: Constants.darkColorScheme,
            colorSchemeSeed: Colors.amber,
            brightness: Brightness.dark, // 테마 고정 ?
            // colorScheme:
            // typography:
          ),
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: Colors.amber,
            // colorSchemeSeed: Color.fromRGBO(r, g, b, opacity),
            brightness: Brightness.light, // 테마 고정 ?
            // colorScheme: Constants.lightColorScheme,
            // primaryColor: Colors.purple[800],

            // colorScheme: Get.isDarkMode
            //     ? Constants.darkColorScheme
            //     : Constants.lightColorScheme,

            // colorScheme:
            // typography:
          ),

          // theme: ThemeData(
          //   // Define the default brightness and colors.
          //   brightness: Brightness.dark,
          //   primaryColor: Colors.lightBlue[800],
          //
          //   // Define the default font family.
          //   fontFamily: 'Georgia',
          //
          //   // Define the default `TextTheme`. Use this to specify the default
          //   // text styling for headlines, titles, bodies of text, and more.
          //   textTheme: const TextTheme(
          //     headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          //     headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          //     bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          //   ),
          // ),
        ));
  }
}
