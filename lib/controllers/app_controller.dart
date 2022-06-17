import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutterex/controllers/base_controller.dart';
import 'package:flutterex/controllers/fire_msg_controller.dart';
import 'package:flutterex/screens/fire_msg_screen.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

///
/// push 샘플
/// https://uaremine.tistory.com/22
/// https://github.com/nicejhkim/flutter_fcm_sample
///
class AppController extends BaseController {
  static AppController get to => Get.find();
  var _isDeviceLight = true.obs;

  get isDeviceLight => _isDeviceLight;

  // var result =
  //     await AndroidChannel.platform.invokeMethod('getAppListFutureFromAOS');
  /**
   * 이프 사이클 종류

      resumed: 앱이 화면에 다시 보이기 시작하는 경우, 유저의 인풋에 반응할 수 있다.
      inactive: 앱이 비활성화되고 유저의 인풋에 반응할 수 없다.
      paused: 앱이 유저에게 보이지 않고, 유저의 인풋에 반응할 수 없으며 백그라운드로 동작한다. (보통 inactive 이후 실행)
      detached(suspending): 모든 뷰가 제거되고 플러터 엔진만 동작 중이며 앱이 종료되기 직전에 실행된다.
      해당 상황은 앱을 스와이프로 제거하거나, 배터리가 부족해서 종료될 때, 메모리 부족으로 스왑될 경우 동작한다. 이 경우 보통 100%의 관찰을 보장하지 않는다.
   */
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);
  //   QcLog.e('didChangeAppLifecycleState : $state');
  //   switch (state) {
  //     case AppLifecycleState.resumed:
  //       break;
  //     case AppLifecycleState.inactive:
  //       break;
  //     case AppLifecycleState.detached:
  //       break;
  //     case AppLifecycleState.paused:
  //       break;
  //   }
  // }

  final _prefs = SharedPreferences.getInstance();

  Future<void> samplePref() async {
    final SharedPreferences prefs = await _prefs;

    var blockAppList = prefs.getBool('APP_THEME') ?? false;
    prefs.setString(
        'SETTING_CHILD_MANAGEMENT_BLOCKS', 'SETTING_CHILD_MANAGEMENT_BLOCKS');
  }

  final Rxn<RemoteMessage> message = Rxn<RemoteMessage>();
  var fcmToken = ''.obs;
  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future<bool> initialize() async {
    QcLog.e('initialize =====');
    // Firebase 초기화부터 해야 Firebase Messaging 을 사용할 수 있다.
    // await Firebase.initializeApp();

    // Android용 새 Notification Channel
    // foreground에서의 푸시 알림 표시를 위한 알림 중요도 설정
    // const AndroidNotificationChannel androidNotificationChannel =
    //     AndroidNotificationChannel(
    //   'high_importance_channel', // 임의의 id
    //   'High Importance Notifications', // 설정에 보일 채널명
    //   description:
    //       'This channel is used for important notifications.', // 설정에 보일 채널 설명
    //   importance: Importance.max,
    // );

    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description:
            'This channel is used for important notifications.', // description
        importance: Importance.high,
      );
    }

    // Notification Channel을 디바이스에 생성
    // foreground에서의 푸시 알림 표시를 위한 local notifications 설정
    // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =  FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    if (Platform.isAndroid) {
      // Android 에서는 별도의 확인 없이 리턴되지만, requestPermission()을 호출하지 않으면 수신되지 않는다.
      await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true,
      );

      await FirebaseMessaging.instance.getToken().then((value) {
        fcmToken.value = value!;
        QcLog.e('fcmToken === $fcmToken');
      }).catchError((error) {
        // error가 해당 에러를 출력
        QcLog.e('error: $error');
      });

      // final fcmToken = await FirebaseMessaging.instance.getToken();
      // QcLog.e('fcmToken === $fcmToken');

    } else if (Platform.isIOS) {
      // iOS foreground에서 heads up display 표시를 위해 alert, sound true로 설정
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true, // Required to display a heads up notification
        badge: true,
        sound: true,
      );

// iOS 권한 요청
//       FirebaseMessaging.instance.requestPermission()
//       FirebaseMessaging.instance.requestNotificationPermissions(
//           IosNotificationSettings(sound: true, badge: true, alert: true));
//       fcm.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
//         print("Settings registered: $settings");
//       });

      var getAPNSToken = await FirebaseMessaging.instance.getAPNSToken();
      QcLog.e('getAPNSToken === $getAPNSToken');
    }

    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      QcLog.e('onTokenRefresh === $fcmToken');
      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
    }).onError((err) {
      QcLog.e('onTokenRefresh onError=== $err');
      // Error getting token.
    });

    // FlutterLocalNotificationsPlugin 초기화. 이 부분은 notification icon 부분에서 다시 다룬다.
    await flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'),
            iOS: IOSInitializationSettings()),
        onSelectNotification: (String? payload) async {
      // Foreground 에서 수신했을 때 생성되는 heads up notification 클릭했을 때의 동작
      QcLog.e('FCM msg Foreground ======= $payload');
      Get.toNamed(FireMsgScreen.routeName,
          // //     arguments: {
          // //   'name': 'title_firebase_messaging'.tr,
          // //   'remoteMsg': payload
          // // }
          arguments: FireMsgArguments('title_firebase_messaging'.tr,
              RemoteMessage.fromMap(json.decode(payload!)), true));
    });

    ///
    ///  RemoteMessage rm
    ///  플랫폼에 관계없이 모든 앱 인스턴스가 다음 공통 필드를 해석할 수 있습니다.
    //
    // message.notification.title
    // message.notification.body
    // message.data

    ///
    /// {
    //   senderId: null,
    //   category: null,
    //   collapseKey: com.example.flutterex,
    //   contentAvailable: false,
    //   data: {
    //     key_2: value_2,
    //     argument: {
    //       id: 1111,
    //       content: content_value,
    //       contentAvailable: false,
    //       data: {
    //         key_1: data_1,
    //         key_2: data_2
    //       }
    //     },
    //     key_1: value_1
    //   },
    //   from: 656621123867,
    //   messageId: 0: 1654757699335279%14bdfb1e14bdfb1e,
    //   messageType: null,
    //   mutableContent: false,
    //   notification: {
    //     title: 제목입력5555,
    //     titleLocArgs: [
    //
    //     ],
    //     titleLocKey: null,
    //     body: 알림테스트5555,
    //     bodyLocArgs: [
    //
    //     ],
    //     bodyLocKey: null,
    //     android: {
    //       channelId: null,
    //       clickAction: null,
    //       color: null,
    //       count: null,
    //       imageUrl: https: //search.pstatic.net/common/?src=http%3A%2F%2Fshop1.phinf.naver.net%2F20200423_55%2F1587571654284IyhaI_JPEG%2F24931488833231600_1776065523.jpg&type=a340,
    //       link: null,
    //       priority: 0,
    //       smallIcon: null,
    //       sound: null,
    //       ticker: null,
    //       tag: campaign_collapse_key_8159578396679446472,
    //       visibility: 0
    //     },
    //     apple: null,
    //     web: null
    //   },
    //   sentTime: 1654757555735,
    //   threadId: null,
    //   ttl: 2419200
    // }
    ///
    FirebaseMessaging.onMessage.listen((RemoteMessage rm) async {
      QcLog.e('Got a message whilst in the foreground!');
      QcLog.e('onMessage ===== ${rm.toMap()}');
      // QcLog.e('onMessage ===== ${rm.toMap().toString()}');
      message.value = rm;
      RemoteNotification? notification = rm.notification;
      AndroidNotification? android = rm.notification?.android;

      BigPictureStyleInformation? bigPictureStyleInformation = null;
      AndroidNotificationDetails androidPlatformChannelSpecifics;

      if (notification != null && android != null && !kIsWeb) {
        QcLog.e(
            'onMessage show NotificationDetails ===== ${notification.toMap()}');
        if (notification.android?.imageUrl != null) {
          String? imgUrl = notification.android?.imageUrl;
          final ByteArrayAndroidBitmap bigPicture =
              // ByteArrayAndroidBitmap(  await _getByteArrayFromUrl( 'https://via.placeholder.com/400x800'));
              ByteArrayAndroidBitmap(await _getByteArrayFromUrl(imgUrl!));

          bigPictureStyleInformation = BigPictureStyleInformation(
            bigPicture,
            // largeIcon: largeIcon,
            contentTitle: 'contentTitle ${notification.title}',
            // htmlFormatContentTitle: true,
            summaryText: 'summaryText ${notification.body}',
            // htmlFormatSummaryText: true
          );
          // final AndroidNotificationDetails androidPlatformChannelSpecifics =
          // AndroidNotificationDetails(
          //     'big text channel id', 'big text channel name',
          //     channelDescription: 'big text channel description',
          //     styleInformation: bigPictureStyleInformation);
        }

        QcLog.e('rm.toMap ==== ' + json.encode(rm.toMap()));

        androidPlatformChannelSpecifics = AndroidNotificationDetails(
            channel.id, channel.name,
            channelDescription: channel.description,
            // 'high_importance_channel', // 임의의 id
            // 'High Importance Notifications', // 설정에 보일 채널명
            // channelDescription:
            //     'This channel is used for important notifications.', // 설정에 보일 채널 설명
            styleInformation: bigPictureStyleInformation);

        flutterLocalNotificationsPlugin.show(
          notification.hashCode, // 0 ?
          notification.title,
          notification.body,
          NotificationDetails(
              android: androidPlatformChannelSpecifics,
              iOS: IOSNotificationDetails(subtitle: 'sub title !!!')),
          // 여기서는 간단하게 data 영역의 임의의 필드(ex. argument)를 사용한다.
          // payload: rm.data['argument'],
          // payload: json.encode(rm.data),
          payload: json.encode(rm.toMap()),
        );
      }
    });

    // Background 상태. Notification 서랍에서 메시지 터치하여 앱으로 돌아왔을 때의 동작은 여기서.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage rm) {
      QcLog.e('onMessageOpenedApp ===== ${rm.data}');
      // Get.toNamed(FireMsgScreen.routeName,  arguments: {'msg': rm.data['argument']});
      // Get.toNamed(FireMsgScreen.routeName, arguments: {rm.data['argument']});
      Get.toNamed(FireMsgScreen.routeName,
          //     arguments: {
          //   'name': 'title_firebase_messaging'.tr,
          //   'remoteMsg': rm.data
          // }
          arguments: FireMsgArguments('title_firebase_messaging'.tr, rm, true));
    });

    /// Terminated 앱종료 상태에서 도착한 메시지에 대한 처리
    /// 앱 백백으로 내린 경우에 푸쉬 클릭시 호출
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? rm) {
      if (rm != null) {
        QcLog.e('initialMessage === ${rm.data}');
        // Get.toNamed(FireMsgScreen.routeName, arguments: {'msg': initialMessage.data['argument']});
        // Get.toNamed(FireMsgScreen.routeName, arguments: {initialMessage.data['argument']});
        Get.toNamed(FireMsgScreen.routeName,
            //     arguments: {
            //   'name': 'title_firebase_messaging'.tr,
            //   'remoteMsg': message.data
            // }
            arguments:
                FireMsgArguments('title_firebase_messaging'.tr, rm, true));
      }
    }).catchError((error) {
      QcLog.e('error: $error');
    });

    return true;
  }

  Future<Uint8List> _getByteArrayFromUrl(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    return response.bodyBytes;
  }
}
