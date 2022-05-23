import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterex/controllers/home_controller.dart';
import 'package:flutterex/datas/model/font_item.dart';
import 'package:flutterex/datas/model/home_item.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:flutterex/screens/font_screen.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:get/get.dart';

class FontListItemForm extends StatefulWidget {
  final FontItem item;

  const FontListItemForm({Key? key, required this.item}) : super(key: key);

  @override
  _FontListItemFormState createState() => _FontListItemFormState(item);
}

class _FontListItemFormState extends State<FontListItemForm> {
  final homeController = Get.find<HomeController>();

  FontItem item;

  _FontListItemFormState(this.item);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          // border: Border.all(
          // color: Theme.of(context).colorScheme.background,
          //   width: 3,
          // ),
          borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            // flex: 4,
            child: Container(
                margin: const EdgeInsets.all(5),
                child: QcText.common(
                  item.styleName,
                  textStyle: item.textStyle,
                  // fontColor: Theme.of(context).colorScheme.onSecondaryContainer,
                )),
          )
        ],
      ),
    );
  }
}
