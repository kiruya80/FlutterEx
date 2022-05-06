import 'dart:convert';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionItem {
  String name;
  Permission permission;
  var status = ''.obs;

  PermissionItem({
    required this.name,
    required this.permission,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'permission': permission,
      'status': status,
    };
  }

  factory PermissionItem.fromMap(Map<String, dynamic> map) {
    return PermissionItem(
      name: map['name'],
      permission: map['permission'],
      // status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PermissionItem.fromJson(String source) =>
      PermissionItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PermissionItem{name: $name, permission: $permission}, status: $status}';
  }
}
