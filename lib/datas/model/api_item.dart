import 'dart:convert';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_item.g.dart';

@JsonSerializable()
class ApiItem {
  String apiLibType;
  String apiStr;
  String api;

  @JsonKey(ignore: true)
  var resultStr;
  @JsonKey(ignore: true)
  var errorStr;
  @JsonKey(ignore: true)
  var resultPretty = ''.obs;

  ApiItem({required this.apiLibType, required this.apiStr, required this.api});

  factory ApiItem.fromJson(Map<String, dynamic> json) =>
      _$ApiItemFromJson(json);
  Map<String, dynamic> toJson() => _$ApiItemToJson(this);

  // Map<String, dynamic> toMap() {
  //   return {
  //     'apiStr': apiStr,
  //     'api': api,
  //     'resultStr': resultStr,
  //     'resultPretty': resultPretty,
  //     'errorStr': errorStr,
  //   };
  // }
  //
  // factory ApiItem.fromMap(Map<String, dynamic> map) {
  //   return ApiItem(
  //     apiStr: map['apiStr'],
  //     api: map['api'],
  //     resultStr: map['resultStr'],
  //     resultPretty: map['resultPretty'],
  //     errorStr: map['errorStr'],
  //   );
  // }
  //
  // String toJson() => json.encode(toMap());
  //
  // factory ApiItem.fromJson(String source) =>
  //     ApiItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ApiItem{apiStr: $apiStr, api: $api, result: $resultStr, resultPretty: $resultPretty, errorStr: $errorStr}';
  }
}
