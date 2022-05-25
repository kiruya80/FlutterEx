import 'dart:convert';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ApiItem {
  String apiStr;
  String api;
  var result = ''.obs;
  var resultPretty = ''.obs;
  var errorStr = ''.obs;

  ApiItem({
    required this.apiStr,
    required this.api,
    required this.result,
    required this.resultPretty,
    required this.errorStr,
  });

  Map<String, dynamic> toMap() {
    return {
      'apiStr': apiStr,
      'api': api,
      'result': result,
      'resultPretty': resultPretty,
      'errorStr': errorStr,
    };
  }

  factory ApiItem.fromMap(Map<String, dynamic> map) {
    return ApiItem(
      apiStr: map['apiStr'],
      api: map['api'],
      result: map['result'],
      resultPretty: map['resultPretty'],
      errorStr: map['errorStr'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiItem.fromJson(String source) =>
      ApiItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ApiItem{apiStr: $apiStr, api: $api, result: $result, resultPretty: $resultPretty, errorStr: $errorStr}';
  }
}
