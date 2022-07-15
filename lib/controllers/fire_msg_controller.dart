import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutterex/constants/android_channel.dart';
import 'package:flutterex/controllers/base_controller.dart';
import 'package:flutterex/datas/model/fcm_send_data.dart';
import 'package:flutterex/network/qc_http_client.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:get/get.dart';

class FireMsgArguments {
  final String name;

  /// The RemoteMessage
  final RemoteMessage message;

  /// Whether this message caused the application to open.
  final bool openedApplication;

  // ignore: public_member_api_docs
  FireMsgArguments(this.name, this.message, this.openedApplication);
}

class FireMsgController extends BaseController {
  var fcmMsg = ''.obs;

  /// todo test
  var serverKey = "AAAAmOGrORs:APA91bF1fV0MSoSEAyDMGnUePd-";
  var fcmToken = "";

  @override
  void onInit() {
    super.onInit();
    // final args = Get.arguments;
    try {
      final FireMsgArguments args = Get.arguments as FireMsgArguments;
      QcLog.e('args : |$args|');

      // final name = args['name'];
      final name = args.name;
      QcLog.e('name : $name');
      title.value = name;
    } catch (e) {}

    // final remoteMsg = args['remoteMsg'];
    // final remoteMsg = args.message;
    // RemoteMessage message = args.message;
    // RemoteNotification? notification = message.notification;
    // if (remoteMsg != null && "" != remoteMsg) {
    // var jsonData = json.decode(args);
    // QcLog.e('jsonData : $jsonData');

    // try {
    //   FcmData fcmData = FcmData.fromJson(remoteMsg);
    //   QcLog.e('fcmData : $fcmData');
    //   fcmMsg.value = fcmData.toString();
    // } catch (e) {
    //   rethrow;
    // }
    // }
  }

  ///
  /// push 보내기 테스트
  ///
  Future<void> sendFcmMsg() async {
    try {
      final String result =
          await AndroidChannel.platform.invokeMethod('sendFcmMsg');
    } on PlatformException catch (e) {
      QcLog.d("InFlutter getIntentValues  Exception: $e");
    } finally {}
  }

  Future<void> sendFcmHttpApi(String serverKey, String token) async {
    var notification = Notification(title: 'title입니다', body: 'body 입니다');
    FcmSendData fcmSendData =
        FcmSendData(to: token, notification: notification);

    QcLog.e('fcmSendData ==== ${fcmSendData.toJson()}');
    // fcmSendData ==== {"to":"cjUuB_i6S4-XCxuXX3XPq1:APA91bH42xmfs-","notification":{"title":"title입니다","body":"body 입니다"}}

    QcCusHttpClient.instance
        .addHeader("Content-Type", "application/json; charset=utf-8");
    QcCusHttpClient.instance.addHeader("Authorization", "key=" + serverKey);

    ///
    ///
    // I/flutter (  503): │         <<<<<<<<<<<<<<  Request  >>>>>>>>>>>>>>>>>>>>>>>
    // I/flutter (  503): │         Request Url   : https://fcm.googleapis.com/fcm/send
    // I/flutter (  503): │         Request header: {Content-Type: application/json; charset=utf-8, Authorization: key=AAAADJStpZA:}
    // I/flutter (  503): │         Request Body  : {"to":"cjUuB_i6S4-XCxuXX3XPq1:APA91bH42xmfs-","notification":{"title":"title입니다","body":"body 입니다"}}
    // I/flutter (  503): │         Request time  : 18:00:30.030
    // I/flutter (  503): │         --------------------------------------
    ///
    ///
    ///
    // I/flutter (  503): │         >>>>>>>>>>>>>>>>>> Response <<<<<<<<<<<<<<<<<<<<<<<<
    // I/flutter (  503): │         Response Url  : (200) https://fcm.googleapis.com/fcm/send
    // I/flutter (  503): │         Response data : {"multicast_id":7645849111101076336,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1657875631203892%4d2ad6cc4d2ad6cc"}]}
    // I/flutter (  503): │         Request time  : 18:00:31.031
    // I/flutter (  503): │         --------------------------------------
    ///
    ///
    await QcCusHttpClient.instance
        .post("fcm.googleapis.com", "fcm/send", body: fcmSendData.toJson())
        .then((_) {
      QcLog.e('then === ');
    }).onError((error, stackTrace) {
      QcLog.e('onError === $error');
    }).catchError((e) {
      QcLog.e('catchError === $e');
    }).whenComplete(() {
      QcLog.e('whenComplete ===');
    });

    ///
    /// 지정 단말기에서 받는 데이터
    ///
    /// onMessage =========== {senderId: null, category: null, collapseKey: com.wjthinkbig.nfmiddle.client, contentAvailable: false, data: {}, from: 54034015632, messageId: 0:1657875631203892%4d2ad6cc4d2ad6cc, messageType: null, mutableContent: false, notification: {title: title입니다, titleLocArgs: [], titleLocKey: null, body: body 입니다, bodyLocArgs: [], bodyLocKey: null, android: {channelId: null, clickAction: null, color: null, count: null, imageUrl: null, link: null, priority: 0, smallIcon: null, sound: null, ticker: null, tag: null, visibility: 0}, apple: null, web: null}, sentTime: 1657875631180, threadId: null, ttl: 2419200}
    ///
    /// onMessage =========== {title: title입니다, titleLocArgs: [], titleLocKey: null, body: body 입니다, bodyLocArgs: [], bodyLocKey: null, android: {channelId: null, clickAction: null, color: null, count: null, imageUrl: null, link: null, priority: 0, smallIcon: null, sound: null, ticker: null, tag: null, visibility: 0}, apple: null, web: null}
    ///
    ///
  }
}
