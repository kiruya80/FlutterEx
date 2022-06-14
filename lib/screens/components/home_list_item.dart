import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterex/controllers/home_controller.dart';
import 'package:flutterex/datas/model/home_item.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:get/get.dart';

class HomeListItemForm extends StatefulWidget {
  final HomeItem item;

  const HomeListItemForm({Key? key, required this.item}) : super(key: key);

  @override
  _HomeListItemFormState createState() => _HomeListItemFormState(item);
}

class _HomeListItemFormState extends State<HomeListItemForm>
    with TickerProviderStateMixin {
  final homeController = Get.find<HomeController>();

  // Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  HomeItem item;
  // late AnimationController _controller;
  _HomeListItemFormState(this.item);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    // return Container(
    //   decoration: BoxDecoration(
    //       color: Colors.white,
    //       border: Border.all(
    //         color: Color(0xFF4D4D4D),
    //         width: 1,
    //       ),
    //       borderRadius: BorderRadius.circular(5)),
    //   // padding: const EdgeInsets.only(right: 30.0),
    //   margin: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
    //   child: Row(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: <Widget>[
    //       Expanded(
    //         // flex: 4,
    //         child:
    //             GestureDetector(
    //           onTap: () {
    //             Print.e("item.routeName == ${item.routeName}");
    //             Get.toNamed(item.routeName);
    //           },
    //           child: Container(
    //               margin: const EdgeInsets.all(20),
    //               child: QcText.subtitle1(item.name)),
    //         )
    //       )
    //     ],
    //   ),
    // );

    return Container(
      // margin: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            // flex: 4,
            child: TextButton(
                onPressed: () async {
                  QcLog.e("item.routeName == ${item.routeName}");
                  Get.toNamed(item.routeName, arguments: {'title': item.title});
                },
                style: TextButton.styleFrom(
                  minimumSize: Size.fromHeight(60),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  // primary: Colors.teal,
                  // backgroundColor: Colors.white,
                ),
                child: QcText.headline6(
                  item.title,
                  fontColor: Theme.of(context).colorScheme.onPrimary,
                )),
            // child: Text(
            //   item.name,
            // )),
          )
        ],
      ),
    );
  }
}
