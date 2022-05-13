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
      Print.e('response === $response');

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

  Future<ResponseModel<PostSample>> postSample() async {
    try {
      var response = await QcHttpClient.instance.post(
        "posts/1",
      );
      return ResponseModel(jsonEncode(response), PostSample.fromJson(response));
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseModel<PostSample>> putample() async {
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
