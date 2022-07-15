import 'package:flutterex/controllers/base_controller.dart';
import 'package:flutterex/datas/model/permission_item.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionController extends BaseController {
  final _permissionList = <PermissionItem>[].obs;

  RxList<PermissionItem> get permissionList => _permissionList;

  @override
  void onInit() {
    QcLog.e('onInit ========= ');
    super.onInit();

    getPermissionItems();
  }

  @override
  void onReady() {
    QcLog.e('onReady ========= ');
    super.onReady();
  }

  Future<List<PermissionItem>> getPermissionItems() async {
    _permissionList.clear();

    Permission.values.forEach((element) {
      var status = element.status;
      PermissionItem item;
      status.then((value) {
        item = PermissionItem(name: element.toString(), permission: element);
        item.status.value = value.name.toString().toUpperCase();
        _permissionList.add(item);
      }).catchError((error) {
        QcLog.e('error: $error');
      });
    });

    return _permissionList;
  }

  void doCheckPermission() async {
    // Permission.va
    await [
      Permission.camera,
      Permission.storage,
      Permission.microphone,
      // Permission.manageExternalStorage,
    ].request();
  }

  Future<void> requestPermission(Permission permission) async {
    final permissionResult = await permission.request();
    QcLog.e("permissionResult == $permissionResult");

    // return permissionResult.isGranted == true;
  }
}
