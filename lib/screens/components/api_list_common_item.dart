import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterex/controllers/home_controller.dart';
import 'package:flutterex/datas/model/api_item.dart';
import 'package:flutterex/datas/model/font_item.dart';
import 'package:flutterex/datas/model/home_item.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:flutterex/screens/font_screen.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:get/get.dart';

class ApiListCommonItemForm extends StatefulWidget {
  final ApiItem item;

  // final VoidCallback? callback;
  final Function(ApiItem)? callback;

  const ApiListCommonItemForm({Key? key, required this.item, this.callback})
      : super(key: key);

  @override
  _FApiListCommonItemFormState createState() =>
      _FApiListCommonItemFormState(item, callback);
}

class _FApiListCommonItemFormState extends State<ApiListCommonItemForm> {
  final homeController = Get.find<HomeController>();

  ApiItem item;

  // VoidCallback? callback;
  Function(ApiItem)? callback;

  _FApiListCommonItemFormState(this.item, this.callback);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: Container(
            height: 200,
            width: Get.width,
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.all(10),
                        child: QcText.bodyText1(item.resultPretty.value))),
                Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        QcText.headline6(item.api),
                        TextButton(
                            onPressed: () async {
                              QcLog.e("item.routeName == ");
                              callback?.call(item);
                            },
                            style: TextButton.styleFrom(
                              minimumSize: Size.fromHeight(60),
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                            child: QcText.headline6(
                              item.apiStr,
                              fontColor:
                                  Theme.of(context).colorScheme.onPrimary,
                            ))
                      ],
                    )),
              ],
            )),
      );
    });
  }
}