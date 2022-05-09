import 'package:flutterex/datas/model/permission_item.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionController extends GetxController {
  var title = "Permission Sample".obs;

  final _permissionList = <PermissionItem>[].obs;

  RxList<PermissionItem> get permissionList => _permissionList;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    final name = args['name'];
    Print.e('name : $name');
    title.value = name;

    getPermissionItems();
  }

  Future<List<PermissionItem>> getPermissionItems() async {
    _permissionList.clear();

    Permission.values.forEach((element) {
      var status = element.status;
      PermissionItem item;
      status.then((value) {
        item =
            new PermissionItem(name: element.toString(), permission: element);
        item.status.value = value.name.toString().toUpperCase();
        _permissionList.add(item);
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
    Print.e("permissionResult == $permissionResult");

    // return permissionResult.isGranted == true;
  }
}
