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
  QcTextFormField({
    Key? key,
    String? hintText,
    TextStyle? textStyle,
    double? fontSize,
    int? hintMaxLines,
    Color? fontColor,
    String? initialValue,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator, // 폼체크등 에러메시로 활용
    bool? multiLine,
    bool? enabled,
    AutovalidateMode? autovalidateMode,
    TextEditingController? controller,
  }) : super(
          key: key,
          style: textStyle != null
              ? textStyle
              : Get.textTheme.bodyText2?.copyWith(
                  fontSize: fontSize,
                  color: fontColor,
                ),
          controller: controller,
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          textInputAction: multiLine == true
              ? TextInputAction.newline
              : TextInputAction.done,
          decoration: InputDecoration(
            border: InputBorder.none,
            isDense: true,
            // errorStyle: const TextStyle(
            //   fontSize: 0,
            // ),
            hintStyle: Get.textTheme.bodyText2?.copyWith(
              color: Colors.white24,
              fontSize: fontSize,
            ),
            hintMaxLines: hintMaxLines ?? 10,
            hintText: hintText,
          ),
          maxLines: multiLine == true ? null : 1,
          enabled: enabled,
        );

  factory QcTextFormField.common({
    Key? key,
    String? hintText,
    TextStyle? textStyle = const TextStyle(),
    double? fontSize,
    int? hintMaxLines,
    Color? fontColor,
    String? initialValue,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    bool? multiLine,
    bool? enabled,
    AutovalidateMode? autovalidateMode,
    TextEditingController? controller,
  }) =>
      QcTextFormField(
          key: key,
          hintText: hintText,
          textStyle: textStyle,
          fontSize: fontSize,
          hintMaxLines: hintMaxLines,
          fontColor: fontColor,
          initialValue: initialValue,
          onSaved: onSaved,
          validator: validator,
          multiLine: multiLine,
          enabled: enabled,
          autovalidateMode: autovalidateMode,
          controller: controller);
}
