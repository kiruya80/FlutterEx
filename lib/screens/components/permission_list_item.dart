import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterex/controllers/home_controller.dart';
import 'package:flutterex/datas/model/permission_item.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionListItemForm extends StatefulWidget {
  final PermissionItem item;
  final int position;

  // final VoidCallback? callback;
  final Function? callback;

  const PermissionListItemForm({
    Key? key,
    required this.position,
    required this.item,
    this.callback,
  }) : super(key: key);

  @override
  _PermissionListItemFormState createState() =>
      _PermissionListItemFormState(position, item, callback);
}

class _PermissionListItemFormState extends State<PermissionListItemForm> {
  final homeController = Get.find<HomeController>();

  PermissionItem item;
  int position;

  // VoidCallback? callback;
  Function? callback;

  _PermissionListItemFormState(
      this.position, this.item, Function? this.callback);

  @override
  Widget build(BuildContext context) {
    Permission perssion = item.permission;

    return Obx(() {
      return Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            QcText.headline6(position.toString()),
            SizedBox(
              width: 10,
            ),
            Expanded(
                flex: 2,
                child: QcText.headline6(
                  item.name,
                )),
            SizedBox(
              width: 20,
            ),
            Expanded(
              flex: 1,
              child: FutureBuilder<PermissionStatus>(
                  future: perssion.status,
                  builder: (BuildContext context,
                      AsyncSnapshot<PermissionStatus> snapshot) {
                    if (snapshot.hasData == true) {
                      var permission = snapshot.data!;
                      var status = permission.name.toString().toUpperCase();
                      // item.status = status;
                      return Container(child: QcText.subtitle1(status));
                    } else {
                      return Container(
                          child: QcText.subtitle1(item.status.value));
                    }
                  }),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              flex: 2,
              child: OutlinedButton(
                  onPressed: () async {
                    Fluttertoast.cancel();
                    if (item.status.toLowerCase() ==
                        PermissionStatus.granted.name) {
                      Fluttertoast.showToast(
                          msg: "권한 승인 완료",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1);
                    } else {
                      // callback?.call(item.permission);
                      // callback?.call();
                      final permissionResult = await item.permission.request();
                      QcLog.e(
                          "permissionResult === ${item.permission.toString()}, ${permissionResult.name}");
                      item.status.value = permissionResult.name.toUpperCase();
                      // openAppSettings();
                      if (permissionResult.isGranted == true) {
                        Fluttertoast.showToast(
                            msg: "권한 승인 완료",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1);
                      } else if (permissionResult.isDenied == true) {
                        // 최초 거부
                        Fluttertoast.showToast(
                            msg: "권한 승인 거부",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1);
                      } else if (permissionResult.isPermanentlyDenied == true) {
                        if (Get.isDialogOpen == true) {
                          Get.back();
                        }
                        Get.dialog(
                          AlertDialog(
                            title: const Text('알림'),
                            content: const Text('앱 설정으로 이동하시겠습니까?'),
                            actions: [
                              TextButton(
                                child: const Text("닫기"),
                                onPressed: () => Get.back(),
                              ),
                              TextButton(
                                child: const Text("이동"),
                                onPressed: () async {
                                  Fluttertoast.showToast(
                                      msg: "권한 승인 거부 앱설정으로 이동",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1);
                                  await openAppSettings();
                                },
                              ),
                            ],
                          ),
                        );
                      } else {
                        Fluttertoast.showToast(
                            msg: "권한 승인 실패",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1);
                      }
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size.fromHeight(80),
                    primary: Colors.teal,
                    backgroundColor: Colors.white,
                  ),
                  child:
                      item.status.toLowerCase() == PermissionStatus.granted.name
                          ? QcText.subtitle1(
                              '권한 승인 완료',
                              fontColor: Colors.blueAccent,
                            )
                          : QcText.subtitle1('권한 승인 요청 필요함',
                              fontColor: Colors.deepOrange)),
            )
          ],
        ),
      );
    });
  }
}
