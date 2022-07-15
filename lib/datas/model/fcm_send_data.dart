import 'dart:convert';

class FcmSendData {
  String to;
  Notification? notification;

  FcmSendData({required this.to, this.notification});

  Map<String, dynamic> toMap() {
    return {
      'to': to,
      'notification': notification?.toMap(),
    };
  }

  factory FcmSendData.fromMap(Map<String, dynamic> map) {
    Notification? notification;
    if (map['notification'] != null) {
      notification = Notification.fromMap(map['notification']);
    }

    return FcmSendData(
      to: map['to'],
      notification: notification,
    );
  }

  String toJson() => json.encode(toMap());

  factory FcmSendData.fromJson(Map<String, dynamic> json) =>
      FcmSendData.fromMap(json);

  @override
  String toString() {
    return 'FcmSendData{to: $to, notification: $notification}';
  }
}

class Notification {
  String title;
  String body;

  Notification({
    required this.title,
    required this.body,
  });

  Map<String, dynamic> toMap() => {
        'title': title,
        'body': body,
      };

  factory Notification.fromMap(Map<String, dynamic> map) {
    return Notification(title: map['title'], body: map['body']);
  }

  String toJson() => json.encode(toMap());

  factory Notification.fromJson(String source) =>
      Notification.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Notification{title: $title, body: $body}';
  }
}
