import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostSample {
  var userId;
  int? id;
  String? title;
  String? body;

  PostSample({this.userId, this.id, this.title, this.body});

  factory PostSample.fromJson(Map<String, dynamic> json) =>
      _$PostSampleFromJson(json);
  Map<String, dynamic> toJson() => _$PostSampleToJson(this);
  Map<String, dynamic> toJsonStr() => _$PostSampleToJsonStr(this);

  // Map<String, dynamic> toMap() {
  //   return {
  //     'userId': userId,
  //     'id': id,
  //     'title': title,
  //     'body': body,
  //   };
  // }
  //
  // factory PostSample.fromMap(Map<String, dynamic> map) {
  //   return PostSample(
  //     userId: map['userId'],
  //     id: map['id'],
  //     title: map['title'],
  //     body: map['body'],
  //   );
  // }
  //
  // String toJson() => json.encode(toMap());
  //
  // // factory PostSample.fromJson(String source) =>
  // //     PostSample.fromMap(json.decode(source));
  // // factory PostSample.fromJson(Map<String, dynamic> json) =>
  // //     PostSample.fromMap(json);
  //
  // factory PostSample.fromJson(Map<String, dynamic> json) {
  //   return PostSample(
  //     userId: json['userId'],
  //     id: json['id'],
  //     title: json['title'],
  //     body: json['body'],
  //   );
  // }

  @override
  String toString() {
    return 'PostSample{userId: $userId, id: $id, title: $title, body: $body}';
  }

// @override
  // String toString() {
  //   // final object = json.decode(result);
  //   // final prettyString = JsonEncoder.withIndent('  ').convert(object);
  //   return 'PostSample{userId: $userId, id: $id, title: $title, body: $body}';
  // }
}
