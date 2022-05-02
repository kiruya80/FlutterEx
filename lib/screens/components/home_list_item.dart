import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterex/controllers/home_controller.dart';
import 'package:flutterex/datas/model/home_item.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:get/get.dart';

class HomeListItemForm extends StatefulWidget {
  final HomeItem item;

  const HomeListItemForm({Key? key, required this.item}) : super(key: key);
  @override
  _HomeListItemFormState createState() => _HomeListItemFormState(item);
}

class _HomeListItemFormState extends State<HomeListItemForm> {
  final homeController = Get.find<HomeController>();
  // Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  HomeItem item;

  _HomeListItemFormState(this.item);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Print.e("_HomeListItemFormState =============");

    return Obx(() {
      return Container(
        height: 80,
        decoration: BoxDecoration(
            color: Colors.orange,
            border: Border.all(
              color: Color(0xFF4D4D4D),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5)),
        padding: const EdgeInsets.only(right: 30.0),
        margin: const EdgeInsets.only(top: 3, bottom: 3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Text(item.name),
              // QcText.bodyText1(item.name)
              // QcText(
              //         app.appName,
              //         fontColor: isDark ? Color(0xFFC4C4C4) : Color(0xFF333333),
              //         fontSize: 20,
              //       ),
            ),
          ],
        ),
      );
    });
  }
}
