import 'dart:convert';

class CommentSample {
  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  CommentSample({this.postId, this.id, this.name, this.email, this.body});

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'id': id,
      'name': name,
      'email': email,
      'body': body,
    };
  }

  factory CommentSample.fromMap(Map<String, dynamic> map) {
    return CommentSample(
      postId: map['postId'],
      id: map['id'],
      name: map['name'],
      email: map['email'],
      body: map['body'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentSample.fromJson(Map<String, dynamic> json) =>
      CommentSample.fromMap(json);

  @override
  String toString() {
    return 'CommentSample {postId: $postId, id: $id, name: $name, email: $email, body: $body}';
  }
}
