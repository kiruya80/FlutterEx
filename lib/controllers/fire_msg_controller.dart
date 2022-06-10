import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterex/datas/model/api_item.dart';
import 'package:flutterex/datas/model/fcm_data.dart';
import 'package:flutterex/datas/model/post_model.dart';
import 'package:flutterex/network/api/api_dio_list.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:flutterex/widget/dialog_widget.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:get/get.dart';

class FireMsgController extends GetxController {
  var title = "FireMsgController".obs;
  var fcmMsg = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    QcLog.e('args : |$args|');

    final name = args['name'];
    QcLog.e('name : $name');

    final remoteMsg = args['remoteMsg'];
    if (remoteMsg != null && "" != remoteMsg) {
      // var jsonData = json.decode(args);
      // QcLog.e('jsonData : $jsonData');

      try {
        FcmData fcmData = FcmData.fromJson(remoteMsg);
        QcLog.e('fcmData : $fcmData');
        fcmMsg.value = fcmData.toString();
      } catch (e) {
        rethrow;
      }
    }
  }
}
