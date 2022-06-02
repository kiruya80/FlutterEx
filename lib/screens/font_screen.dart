import 'package:flutter/material.dart';
import 'package:flutterex/controllers/font_controller.dart';
import 'package:flutterex/datas/model/font_item.dart';
import 'package:flutterex/screens/components/font_list_item.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:get/get.dart';

class FontScreen extends StatelessWidget {
  static const routeName = '/font';

  const FontScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FontController controller = Get.find<FontController>();

    QcLog.e(
        'Get.rawRoute?.settings == ${Get.rawRoute?.settings} , ${Get.rawRoute?.settings.name.toString()}');
    QcLog.e(
        'Get.routing?.settings == ${Get.routing.route} , ${Get.routing.route?.settings.name.toString()}');
    return Scaffold(
      appBar: AppBar(
        title: QcText.headline6(controller.title.value),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),

      body: SafeArea(
        // maintainBottomViewPadding 키보드가 올라온 경우 밀어낼지 덮을지 결정
        // maintainBottomViewPadding: false,
        child: Container(
            color: Theme.of(context).colorScheme.background,
            width: Get.width,
            height: Get.height,
            child: FutureBuilder<List<FontItem>>(
              future: controller.makeFontData(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<FontItem>> snapshot) {
                //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
                if (snapshot.hasData == false) {
                  return Container(
                      child: Center(child: CircularProgressIndicator()));
                } else if (snapshot.hasError) {
                  return Container(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.white),
                    ),
                  ));
                } else {
                  List<FontItem> items = snapshot.data!;
                  return Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int position) {
                        FontItem item = items[position];

                        return Column(
                          children: <FontListItemForm>[
                            FontListItemForm(item: item),
                          ],
                        );
                      },
                    ),
                  );
                }
              },
            )),
      ),

      // body: SingleChildScrollView(
      //   scrollDirection: Axis.vertical,
      //   child: Column(
      //     children: [
      //       Container(
      //         width: Get.width,
      //         height: 150,
      //         color: Colors.amberAccent,
      //       ),
      //       Container(
      //         width: Get.width,
      //         height: 150,
      //         color: Colors.blueAccent,
      //       ),
      //     ],
      //   ),
      // )
    );
  }
}
