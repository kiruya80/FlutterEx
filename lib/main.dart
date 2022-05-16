import 'package:flutter/material.dart';
import 'package:flutterex/constants/constant.dart';
import 'package:flutterex/get_x_router.dart';
import 'package:flutterex/langs/languages.dart';
import 'package:flutterex/screens/home_screen.dart';
import 'package:flutterex/utils/print_log.dart';
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

          theme: ThemeData(
            useMaterial3: true,
            // primaryColor: Colors.purple[800],
            colorScheme: Constants.lightColorScheme,
            // colorScheme: Get.isDarkMode
            //     ? Constants.darkColorScheme
            //     : Constants.lightColorScheme,

            // colorScheme:
            // typography:
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            // primaryColor: Colors.purple[800],
            colorScheme: Constants.darkColorScheme,

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
