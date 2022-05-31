import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutterex/constants/ThemeService.dart';
import 'package:flutterex/constants/constant.dart';
import 'package:flutterex/firebase/firebase_options.dart';
import 'package:flutterex/get_x_router.dart';
import 'package:flutterex/langs/languages.dart';
import 'package:flutterex/screens/home_screen.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import 'package:flutter/foundation.dart';

Future<void> main() async {
  // runZonedGuarded : 버튼등 onPressed 에서 발생하는 오류 체크 위해
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    getDeviceTheme();

    FirebaseApp app = await Firebase.initializeApp();
    QcLog.e('FirebaseApp : $app');
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
    // flutter 내에서 발생하는 모든 error을 수집
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    runApp(MyApp());
  }, (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
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
  var title = "HttpApiController".obs;
  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    var seedColor = Colors.green;

    // var seedColorScheme = ColorScheme.fromSeed(seedColor: SEED_COLOR);
    // seedColorScheme.secondary
    return GestureDetector(
        onTap: () {
          QcLog.e('title ${title.value}');
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
            // colorScheme: QcTheme.darkColorScheme,
            colorSchemeSeed: QcTheme.SEED_COLOR,
            brightness: Brightness.dark, // 테마 고정 ?
            // colorScheme:
            // typography:
          ),
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: QcTheme.SEED_COLOR,
            // colorSchemeSeed: Color.fromRGBO(r, g, b, opacity),
            brightness: Brightness.light, // 테마 고정 ?
            // colorScheme: QcTheme.lightColorScheme,
            // primaryColor: Colors.purple[800],

            // colorScheme: Get.isDarkMode
            //     ? QcTheme.darkColorScheme
            //     : QcTheme.lightColorScheme,

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
