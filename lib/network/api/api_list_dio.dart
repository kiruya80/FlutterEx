import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:flutterex/datas/model/comment_model.dart';
import 'package:flutterex/datas/model/post_model.dart';
import 'package:flutterex/datas/model/response_model.dart';
import 'package:flutterex/network/dio_client.dart';
import 'package:flutterex/network/http_client.dart';
import 'package:flutterex/utils/print_log.dart';

class ApiListDio {
  static String postParamConvert(Object data) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(json.encode(data).toString());

    return encoded;
  }

  Future<ResponseModel<List<PostSample>>> getPostList({
    Map<String, dynamic>? params,
  }) async {
    try {
      var response =
          await QcDioClient.instance.get("posts", queryParams: params);
      QcLog.e('response === $response');

      var list = (response as List).map((_) {
        // return PostSample.fromMap(_);
        return PostSample.fromJson(_);
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
        // return PostSample.fromMap(_);
        return PostSample.fromJson(_);
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
    // var body = {
    //   "title": 'foo',
    //   "body": 'bar',
    //   "userId": '1',
    // };

    // String encoded = postParamConvert(body);
    // QcLog.e('encoded ====  $encoded');

    // final body = <String, dynamic>{
    //   "title": 'foo',
    //   "body": 'bar',
    //   "userId": '1'
    // };

    // final bytes = utf8.encode(json.encode(params.toString()));
    // QcLog.e("bytes === " + bytes.toString());
    // final body = base64Encode(bytes).codeUnits;
    // QcLog.e("body === " + body.toString());

    try {
      var body = postSample.toJsonStr();
      QcLog.e('body ====  $body');

      var response = await QcHttpClient.instance.post("posts",
          // body: '{"title": "Foo","body": "Bar", "userId": 99}',
          queryParams: null,
          body: body);
      return ResponseModel(jsonEncode(response), PostSample.fromJson(response));
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseModel<PostSample>> putSample(PostSample postSample) async {
    try {
      var body = postSample.toJsonStr();
      QcLog.e('body ====  $body');

      var response = await QcHttpClient.instance.put(
        "posts/1",
      );
      return ResponseModel(jsonEncode(response), PostSample.fromJson(response));
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseModel<PostSample>> patchSample(var body) async {
    try {
      var response = await QcHttpClient.instance.patch("posts/1", body: body);
      return ResponseModel(jsonEncode(response), PostSample.fromJson(response));
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseModel<PostSample>> deleteSample(String postId) async {
    QcLog.e('deleteSample =============== $postId');
    try {
      var response = await QcHttpClient.instance.delete(
        "posts/$postId",
        // "posts/1",
      );
      return ResponseModel(jsonEncode(response), PostSample.fromJson(response));
    } catch (e) {
      rethrow;
    }
  }
}
