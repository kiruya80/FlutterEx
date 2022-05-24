import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QcTextFormField extends TextFormField {
  static const MAX_LINES = 10;

  QcTextFormField({
    Key? key,
    String? labelText,
    String? hintText,
    bool autofocus = false,
    bool expands = false,
    bool readOnly = false, // 키보드 감추기
    bool enabled = true,
    FocusNode? focusNode,
    TextStyle? textStyle,
    String? fontFamily,
    TextInputType? keyboardType,
    InputDecoration? decoration = const InputDecoration(),
    TextInputAction? textInputAction,
    double? fontSize,
    int? hintMaxLines,
    Color? fontColor,
    String? initialValue,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator, // 폼체크등 에러메시로 활용
    int? maxLines,
    int? minLines,
    int? maxLength,
    AutovalidateMode? autovalidateMode,
    TextEditingController? controller,
  }) : super(
            key: key,
            style: TextStyle(
              color: fontColor,
              fontSize: fontSize ?? textStyle?.fontSize,
              fontWeight: textStyle?.fontWeight,
              letterSpacing: textStyle?.letterSpacing,
              leadingDistribution: textStyle?.leadingDistribution,
              fontFamily: fontFamily ?? "NanumSquare",
            ),
            controller: controller,
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            textInputAction: textInputAction,
            decoration: InputDecoration(
              // 텍스트필드의 외각선
              //   hintMaxLines: hintMaxLines,
              filled: true,
              hintText: hintText,
              labelText: labelText,
              // focusedBorder: OutlineInputBorder(
              //   borderRadius:
              //       BorderRadius.all(Radius.circular(10.0)),
              // ),
              // unfocused
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              // focused
              // border: InputBorder.none,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                // borderSide: BorderSide(
                //     width: 1, color: Colors.redAccent),
              ),
            ),
            maxLines: expands == true
                ? null
                : getMaxLines(maxLines ?? 1, minLines ?? 1),
            minLines: expands == true ? null : minLines,
            maxLength: maxLength,
            expands: expands,
            enabled: enabled,
            focusNode: focusNode,
            autofocus: autofocus);

  static getMaxLines(
    int maxLines,
    int minLines,
  ) {
    if (maxLines < minLines) {
      maxLines = minLines;
    }

    return maxLines;
  }

  /**
   * enabled : 비활성화 회색
   * expands : 부모뷰 다 채우기
   */
  factory QcTextFormField.common({
    Key? key,
    String? labelText,
    String? hintText,
    bool autofocus = false,
    bool expands = false,
    bool readOnly = false,
    bool enabled = true,
    FocusNode? focusNode,
    TextStyle? textStyle = const TextStyle(),
    TextInputType? keyboardType,
    InputDecoration? decoration,
    TextInputAction? textInputAction,
    double? fontSize,
    int? hintMaxLines,
    Color? fontColor,
    String? initialValue,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    int? maxLines = 1,
    int? minLines,
    int? maxLength,
    AutovalidateMode? autovalidateMode,
    TextEditingController? controller,
  }) =>
      QcTextFormField(
          key: key,
          labelText: labelText,
          hintText: hintText,
          autofocus: autofocus,
          expands: expands,
          readOnly: readOnly,
          enabled: enabled,
          focusNode: focusNode,
          textStyle: textStyle,
          keyboardType: keyboardType,
          decoration: decoration,
          textInputAction: textInputAction,
          fontSize: fontSize,
          hintMaxLines: hintMaxLines,
          fontColor: fontColor,
          initialValue: initialValue,
          onSaved: onSaved,
          validator: validator,
          maxLines: maxLines,
          minLines: minLines,
          maxLength: maxLength,
          autovalidateMode: autovalidateMode,
          controller: controller);

  factory QcTextFormField.headline6({
    Key? key,
    String? labelText,
    String? hintText,
    bool autofocus = false,
    bool expands = false,
    bool readOnly = false,
    bool enabled = true,
    FocusNode? focusNode,
    TextInputType? keyboardType,
    InputDecoration? decoration,
    TextInputAction? textInputAction,
    double? fontSize,
    int? hintMaxLines,
    Color? fontColor,
    String? initialValue,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    int? maxLines = 1,
    int? minLines,
    int? maxLength,
    AutovalidateMode? autovalidateMode,
    TextEditingController? controller,
  }) =>
      QcTextFormField(
          key: key,
          labelText: labelText,
          hintText: hintText,
          autofocus: autofocus,
          expands: expands,
          readOnly: readOnly,
          enabled: enabled,
          focusNode: focusNode,
          textStyle: Get.theme.textTheme.headline6,
          keyboardType: keyboardType,
          decoration: decoration,
          textInputAction: textInputAction,
          fontSize: fontSize,
          hintMaxLines: hintMaxLines,
          fontColor: fontColor,
          initialValue: initialValue,
          onSaved: onSaved,
          validator: validator,
          maxLines: maxLines,
          minLines: minLines,
          maxLength: maxLength,
          autovalidateMode: autovalidateMode,
          controller: controller);

  factory QcTextFormField.bodyText1({
    Key? key,
    String? labelText,
    String? hintText,
    bool autofocus = false,
    bool expands = false,
    // bool readOnly = false,
    FocusNode? focusNode,
    TextInputType? keyboardType,
    InputDecoration? decoration,
    TextInputAction? textInputAction,
    double? fontSize,
    int? hintMaxLines,
    Color? fontColor,
    String? initialValue,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    int? maxLines = 1,
    int? minLines,
    int? maxLength,
    AutovalidateMode? autovalidateMode,
    TextEditingController? controller,
  }) =>
      QcTextFormField(
          key: key,
          labelText: labelText,
          hintText: hintText,
          autofocus: autofocus,
          expands: expands,
          // readOnly: readOnly,
          focusNode: focusNode,
          textStyle: Get.theme.textTheme.bodyText1,
          keyboardType: keyboardType,
          decoration: decoration,
          textInputAction: textInputAction,
          fontSize: fontSize,
          hintMaxLines: hintMaxLines,
          fontColor: fontColor,
          initialValue: initialValue,
          onSaved: onSaved,
          validator: validator,
          maxLines: maxLines,
          minLines: minLines,
          maxLength: maxLength,
          autovalidateMode: autovalidateMode,
          controller: controller);
}
