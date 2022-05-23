import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// NAME         SIZE  WEIGHT  SPACING
/// headline1    96.0  light   -1.5
/// headline2    60.0  light   -0.5
/// headline3    48.0  regular  0.0
/// headline4    34.0  regular  0.25
/// headline5    24.0  regular  0.0
/// headline6    20.0  medium   0.15
/// subtitle1    16.0  regular  0.15
/// subtitle2    14.0  medium   0.1
/// body1        16.0  regular  0.5   (bodyText1)
/// body2        14.0  regular  0.25  (bodyText2)
/// button       14.0  medium   1.25
/// caption      12.0  regular  0.4
/// overline     10.0  regular  1.5
class QcTextFormField extends TextFormField {
  static const MAX_LINES = 10;

  QcTextFormField({
    Key? key,
    String? labelText,
    String? hintText,
    bool autofocus = false,
    bool expands = false,
    bool readOnly = false,
    bool enabled = true,
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
            // style: textStyle != null
            //     ? textStyle
            //     : Get.textTheme.bodyText2?.copyWith(
            //         fontSize: fontSize,
            //         color: fontColor,
            //       ),
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
              filled: true,
              hintText: hintText,
              labelText: labelText,
              //   hintMaxLines: hintMaxLines,
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
