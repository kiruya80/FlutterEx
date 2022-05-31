import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterex/datas/model/api_item.dart';
import 'package:flutterex/datas/model/post_model.dart';
import 'package:flutterex/network/api/api_dio_list.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:flutterex/widget/dialog_widget.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:get/get.dart';

class FireAnalyticsController extends GetxController {
  var title = "FireAnalyticsController".obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    final name = args['name'];
    QcLog.e('name : $name');
    title.value = name;
  }
}
