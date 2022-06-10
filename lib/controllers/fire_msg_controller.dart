import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutterex/datas/model/api_item.dart';
import 'package:flutterex/datas/model/fcm_data.dart';
import 'package:flutterex/datas/model/post_model.dart';
import 'package:flutterex/network/api/api_dio_list.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:flutterex/widget/dialog_widget.dart';
import 'package:flutterex/widget/text_widget.dart';
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

class FireMsgController extends GetxController {
  var title = "FireMsgController".obs;
  var fcmMsg = ''.obs;

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
}
