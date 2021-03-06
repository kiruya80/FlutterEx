import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutterex/constants/theme_service.dart';
import 'package:flutterex/controllers/app_controller.dart';
import 'package:flutterex/firebase/firebase_options.dart';
import 'package:flutterex/get_x_router.dart';
import 'package:flutterex/langs/languages.dart';
import 'package:flutterex/screens/home_screen.dart';
import 'package:flutterex/service/qc_firebase_analytics_observer.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

Future<void> main() async {
  /// runZonedGuarded : 버튼등 onPressed 에서 발생하는 오류 체크 위해
  /// zone은 프로그램이 예상치 못한 에러로부터 종료하는 걸 막을 때 쓰입니다.
  /// 일반적인 상황이면 프로그램이 종료되는 경우더라도 zone(존)을 쓰면 잘 돌아가게 되는 거죠.
  /// Zone을 쓰면 계속 프로그램이 실행됩니다.
  ///
  await runZonedGuarded(() async {
    /// WidgetsFlutterBinding.ensureInitialized()은 반드시 runZonedGuarded 내부에서 호출
    WidgetsFlutterBinding.ensureInitialized();
    getDeviceTheme();

    FirebaseApp app = await Firebase.initializeApp();
    QcLog.e('FirebaseApp : $app');
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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

///
/// todo 앱이 백그라운드에 있거나 종료될 때 트리거할 백그라운드 메시지 핸들러를 설정합니다.
/// todo 앱종료시 테스트는 릴리즈로 빌드하면 나온다
///
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  QcLog.e(
      "Handling a background message: ${message.messageId}, ${message.data.toString()}");

  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  /// 종료되었을 경우등 Firebase 초기화 필수
  await Firebase.initializeApp();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  var msg = message.notification?.toMap();
  // {title: title입니다, titleLocArgs: [], titleLocKey: null, body: body 입니다, bodyLocArgs: [], bodyLocKey: null,
  // android: {channelId: null, clickAction: null, color: null, count: null, imageUrl: null, link: null, priority: 0, smallIcon: null, sound: null, ticker: null, tag: null, visibility: 0}, apple: null, web: null}

  String? title = message.notification?.title.toString();
  String? body = message.notification?.body.toString();

  Fluttertoast.showToast(
      msg: "title : $title \n body : $body",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1);
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
  final AppController appController = Get.put(AppController());
  var title = "HttpApiController".obs;

  /**
   * GetX를 사용하는 경우에는 Get.to() 에는 RouteSetting.name을 설정할 수 없기 때문에 Get.toNamed()를 사용해야 한다.
   *  NamedRoute를 사용할 수 없는 경우에는
   *  analytics.setCurrentScreen(screenName: screenName)를 직접 호출해줘도 되겠다.
   *  기본적으로 불리는 screen_view 이벤트와 겹쳐서 screen_view count에 영향을 줄 수도 있으니 잘 확인하고 사용하자.
   *
   *  https://uaremine.tistory.com/21
   *
   *    디버그 모드 시작
   *    adb shell setprop debug.firebase.analytics.app com.example.flutterex
   *
   *    디버그 모드 중지
   *    adb shell setprop debug.firebase.analytics.app .none.
   */
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  // static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);
  static QcFirebaseAnalyticsObserver observer =
      QcFirebaseAnalyticsObserver(analytics: analytics);

  Future logAppOpen() async {
    await analytics.logAppOpen();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    // var seedColor = Colors.green;
    logAppOpen();
    appController.init();

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
          defaultTransition: Transition.native,
          // localizationsDelegates: context.localizationDelegates,
          // supportedLocales: context.supportedLocales,
          navigatorObservers: <NavigatorObserver>[
            observer,
          ],
          // navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)],

          translations: Languages(),
          locale: Get.deviceLocale,
          fallbackLocale: const Locale('ko', 'KR'),

          smartManagement: SmartManagement.keepFactory,
          debugShowCheckedModeBanner: kDebugMode,
          title: "Flutter Sample",
          getPages: GetXRouterContainer().allPageRouter,
          // unknownRoute: GetPage(name: '/notfound', page: () => UnknownRoutePage()),

          // routingCallback: (routing) {
          //   if(routing.current == '/second'){
          //     openAds();
          //   }
          // }
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
