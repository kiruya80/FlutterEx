import 'package:flutter/material.dart';
import 'package:flutterex/controllers/multi_lang_controller.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:get/get.dart';

class MultiLangScreen extends StatelessWidget {
  static const routeName = '/multiLang';

  const MultiLangScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MultiLangController controller = Get.find<MultiLangController>();
    return Scaffold(
      appBar: AppBar(
        title: QcText.headline6(controller.title.value),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: Get.width,
                    height: 80,
                    child: QcText.subtitle1(
                        'locale languageCode :  ${Get.locale?.languageCode.toString()} , countryCode : ${Get.locale?.countryCode.toString()} '),
                  ),
                  OutlinedButton(
                      onPressed: () async {
                        if (controller.lang.value == 'ko') {
                          Get.updateLocale(const Locale('ja', 'JP'));
                          controller.lang.value = 'ja';
                        } else if (controller.lang.value == 'ja') {
                          Get.updateLocale(const Locale('en', 'US'));
                          controller.lang.value = 'en';
                        } else {
                          Get.updateLocale(const Locale('ko', 'KR'));
                          controller.lang.value = 'ko';
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.fromHeight(80),
                        // primary:
                        //     Theme.of(context).colorScheme.secondaryContainer,
                        backgroundColor:
                            Theme.of(context).colorScheme.secondaryContainer,
                      ),
                      child: QcText.subtitle1('greeting'.tr)),
                  SizedBox(
                    height: 20,
                  ),
                  /**
                   * ㄴ Row (가로로 아이템이 쌓임)
                   * ㄴ Colum (세로로 아이템이 쌓임)
                   *
                   * MainAxisAlignment 아이템이 쌓이는 방향
                   * CrossAxisAlignment 아이템 하나의 방향
                   *
                   */
                  QcText.headline6(
                    'Row (가로로 아이템이 쌓임)\nColum (세로로 아이템이 쌓임)',
                  ),
                  QcText.bodyText1(
                    'MainAxisAlignment 아이템이 쌓이는 방향\nCrossAxisAlignment 아이템 하나의 방향',
                  ),
                  Container(
                    width: Get.width,
                    height: 200,
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    child: Row(mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          FlutterLogo(),
                          QcText.headline6(
                              'Row - mainAxisAlignment: MainAxisAlignment.end'),
                          Icon(Icons.sentiment_very_satisfied),
                        ]),
                  ),
                  Container(
                    width: Get.width,
                    height: 200,
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          FlutterLogo(),
                          QcText.headline6(
                              'Row - mainAxisAlignment: MainAxisAlignment.end'),
                          Icon(Icons.sentiment_very_satisfied),
                        ]),
                  ),
                  Container(
                    width: Get.width,
                    height: 200,
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    child: Row(mainAxisAlignment: MainAxisAlignment.end,
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          FlutterLogo(),
                          QcText.headline6(
                              'Row - mainAxisAlignment: MainAxisAlignment.end'),
                          Icon(Icons.sentiment_very_satisfied),
                        ]),
                  ),

                  Container(
                    width: Get.width,
                    height: 200,
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                    child: Column(mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          FlutterLogo(),
                          QcText.headline6(
                              'Column - mainAxisAlignment: MainAxisAlignment.end'),
                          Icon(Icons.sentiment_very_satisfied),
                        ]),
                  ),
                  Container(
                    width: Get.width,
                    height: 200,
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          FlutterLogo(),
                          QcText.headline6(
                              'Column - mainAxisAlignment: MainAxisAlignment.end'),
                          Icon(Icons.sentiment_very_satisfied),
                        ]),
                  ),
                  Container(
                    width: Get.width,
                    height: 200,
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                    child: Column(mainAxisAlignment: MainAxisAlignment.end,
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          FlutterLogo(),
                          QcText.headline6(
                              'Column - mainAxisAlignment: MainAxisAlignment.end'),
                          Icon(Icons.sentiment_very_satisfied),
                        ]),
                  ),

                  Container(
                    width: Get.width,
                    height: 200,
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          FlutterLogo(),
                          QcText.headline6(
                              'Column - mainAxisAlignment: MainAxisAlignment.end'),
                          Icon(Icons.sentiment_very_satisfied),
                        ]),
                  ),

                  Container(
                    width: Get.width,
                    height: 200,
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          FlutterLogo(),
                          QcText.headline6(
                              'Column - mainAxisAlignment: MainAxisAlignment.end'),
                          Icon(Icons.sentiment_very_satisfied),
                        ]),
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // Container(
                  //   width: Get.width,
                  //   height: 80,
                  //   color: Colors.blueAccent,
                  // ),
                ],
              ),
            )),
      ),
    );
  }
}
