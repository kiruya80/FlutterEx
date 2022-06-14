import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutterex/controllers/base_controller.dart';
import 'package:flutterex/utils/print_log.dart';
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

class FireMsgController extends BaseController {
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
