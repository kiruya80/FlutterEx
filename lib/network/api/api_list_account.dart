import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:flutterex/datas/model/comment_model.dart';
import 'package:flutterex/datas/model/post_model.dart';
import 'package:flutterex/datas/model/response_model.dart';
import 'package:flutterex/network/http_client.dart';
import 'package:flutterex/utils/print_log.dart';

class ApiListAccount {
  Future<ResponseModel<List<PostSample>>> getPostList({
    Map<String, dynamic>? params,
  }) async {
    try {
      var response =
          await QcHttpClient.instance.get("posts", queryParams: params);
      // return PostSample.fromMap(response['RESP_RESULT']);
      var list = (response as List).map((_) {
        return PostSample.fromMap(_);
      }).toList();
      return ResponseModel(jsonEncode(response), list);
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseModel<List<PostSample>>> getPostList1({
    Map<String, dynamic>? params,
  }) async {
    try {
      var response =
          await QcHttpClient.instance.get("posts", queryParams: params);
      // return PostSample.fromMap(response['RESP_RESULT']);
      var list = (response as List).map((_) {
        return PostSample.fromMap(_);
      }).toList();
      return ResponseModel(jsonEncode(response), list);
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseModel<PostSample>> getOnePost() async {
    try {
      var response = await QcHttpClient.instance.get(
        "posts/1",
      );
      QcLog.e('response === $response');

      // return PostSample.fromMap(response['RESP_RESULT']);
      return ResponseModel(jsonEncode(response), PostSample.fromJson(response));
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseModel<List<CommentSample>>> getPostComments({
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      var response = await QcHttpClient.instance
          .get("posts/1/comments", queryParams: queryParams);
      var list = (response as List).map((_) {
        return CommentSample.fromMap(_);
      }).toList();
      return ResponseModel(jsonEncode(response), list);
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseModel<List<CommentSample>>> getComments({
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      var response =
          await QcHttpClient.instance.get("comments", queryParams: queryParams);
      var list = (response as List).map((_) {
        return CommentSample.fromMap(_);
      }).toList();
      return ResponseModel(jsonEncode(response), list);
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseModel<PostSample>> postSample(PostSample postSample) async {
    QcLog.e('postSample ====  ${postSample.toString()}');
    var data = {
      "title": 'foo',
      "body": 'bar',
      "userId": 1,
    };

    String encoded = postParamConvert(data);
    // String encoded;
    // encoded = data as String;
    // encoded = postSample.toJson();
    QcLog.e('encoded ====  $encoded');

    try {
      var response = await QcHttpClient.instance.post(
        "posts",
        body: encoded,
      );
      return ResponseModel(jsonEncode(response), PostSample.fromJson(response));
    } catch (e) {
      rethrow;
    }
  }

  static String postParamConvert(Object data) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(json.encode(data).toString());

    return encoded;
  }

  Future<ResponseModel<PostSample>> putSample() async {
    try {
      var response = await QcHttpClient.instance.get(
        "posts/1",
      );
      return ResponseModel(jsonEncode(response), PostSample.fromJson(response));
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseModel<PostSample>> patchSample() async {
    try {
      var response = await QcHttpClient.instance.get(
        "posts/1",
      );
      return ResponseModel(jsonEncode(response), PostSample.fromJson(response));
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseModel<PostSample>> deleteSample() async {
    try {
      var response = await QcHttpClient.instance.get(
        "posts/1",
      );
      return ResponseModel(jsonEncode(response), PostSample.fromJson(response));
    } catch (e) {
      rethrow;
    }
  }
}
