import 'dart:convert';

class FcmData {
  String routeName;
  String data;

  FcmData({
    required this.routeName,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'routeName': routeName,
      'data': data,
    };
  }

  factory FcmData.fromMap(Map<String, dynamic> map) {
    return FcmData(
      routeName: map['routeName'],
      data: map['data'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FcmData.fromJson(String source) =>
      FcmData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FcmData{routeName: $routeName, data: $data}';
  }
}
