// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiItem _$ApiItemFromJson(Map<String, dynamic> json) => ApiItem(
      apiLibType: json['apiLibType'] as String,
      apiStr: json['apiStr'] as String,
      api: json['api'] as String,
      // resultStr: json['resultStr'] as String,
      // errorStr: json['errorStr'] as String,
    );

Map<String, dynamic> _$ApiItemToJson(ApiItem instance) => <String, dynamic>{
      'apiLibType': instance.apiLibType,
      'apiStr': instance.apiStr,
      'api': instance.api,
      // 'resultStr': instance.resultStr,
      // 'errorStr': instance.errorStr,
    };
