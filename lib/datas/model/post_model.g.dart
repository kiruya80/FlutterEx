// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostSample _$PostSampleFromJson(Map<String, dynamic> json) => PostSample(
      // userId: json['userId'] as int?,
      userId: json['userId'],
      id: json['id'] as int?,
      title: json['title'] as String?,
      body: json['body'] as String?,
    );

Map<String, dynamic> _$PostSampleToJson(PostSample instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
    };

Map<String, dynamic> _$PostSampleToJsonStr(PostSample instance) =>
    <String, dynamic>{
      'userId': instance.userId.toString(),
      'id': instance.id.toString(),
      'title': instance.title.toString(),
      'body': instance.body.toString(),
    };
