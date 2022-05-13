import 'dart:convert';

class ResponseModel<T> {
  String bodyStr = '';
  T? bodyModel;

  ResponseModel(this.bodyStr, this.bodyModel);
}
