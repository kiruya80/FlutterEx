import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterex/controllers/app_controller.dart';
import 'package:flutterex/controllers/dio_api_controller.dart';
import 'package:flutterex/controllers/http_api_controller.dart';
import 'package:flutterex/controllers/fire_msg_controller.dart';
import 'package:flutterex/datas/model/api_item.dart';
import 'package:flutterex/screens/components/api_item.dart';
import 'package:flutterex/service/qc_notification_utils.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:get/get.dart';
import 'package:loading_animations/loading_animations.dart';

/// https://eunjin3786.tistory.com/280
///
///
/// https://sudarlife.tistory.com/entry/Flutter-%ED%94%8C%EB%9F%AC%ED%84%B0-%EC%82%BD%EC%A7%88%EC%9D%80-%EA%B7%B8%EB%A7%8C-Firebase-Messaging-iOS-%EC%85%8B%EC%97%85
/// https://babbab2.tistory.com/58?category=831129
///
///
class FireMsgScreen extends StatelessWidget {
  static const routeName = '/fire/Msg';

  const FireMsgScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QcLog.e("PushScreen =============");
    FireMsgController controller = Get.find<FireMsgController>();
    AppController appController = Get.find<AppController>();

    return Obx(() {
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
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  QcText.headline6('Token : ' + appController.fcmToken.value),
                  SizedBox(
                    height: 20,
                  ),
                  QcText.bodyText1('FCM msg : ' + controller.fcmMsg.value),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50),
                      ),
                      onPressed: () async {
                        QcNotificationUtils.instance.cancelAllNotifications();
                      },
                      child: QcText.headline6(
                        'FCM msg clear',
                        // fontColor: Theme.of(context).colorScheme.onPrimary,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                ],
              )),
        ),
      );
    });
  }
}