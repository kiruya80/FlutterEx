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
class QcText extends Text {
  static const MAX_LINES = 200;

  QcText(String text,
      {Key? key,
      TextStyle? textStyle,
      Color? fontColor,
      double? fontSize,
      FontWeight? fontWeight,
      String? fontFamily,
      TextAlign? textAlign,
      int? maxLines,
      TextDecoration? decoration})
      : super(text,
            key: key,
            overflow: TextOverflow.ellipsis,
            maxLines: maxLines ?? MAX_LINES,
            style: TextStyle(
                color: fontColor,
                fontSize: fontSize ?? textStyle?.fontSize,
                fontWeight: fontWeight ?? textStyle?.fontWeight,
                letterSpacing: textStyle?.letterSpacing,
                leadingDistribution: textStyle?.leadingDistribution,
                fontFamily: fontFamily ?? "NanumSquare",
                decoration: decoration),
            textAlign: textAlign ?? TextAlign.left);

  factory QcText.common(String text,
          {Key? key,
          TextStyle? textStyle,
          Color? fontColor,
          double? fontSize,
          FontWeight? fontWeight,
          String? fontFamily,
          TextAlign? textAlign,
          int? maxLines,
          TextDecoration? decoration}) =>
      QcText(text,
          key: key,
          textStyle: textStyle,
          fontColor: fontColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: fontFamily,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration);

  factory QcText.headline1(String text,
          {Key? key,
          Color? fontColor,
          double? fontSize,
          FontWeight? fontWeight,
          String? fontFamily,
          TextAlign? textAlign,
          int? maxLines,
          TextDecoration? decoration}) =>
      QcText(text,
          key: key,
          textStyle: Get.theme.textTheme.headline1,
          fontColor: fontColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: fontFamily,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration);

  factory QcText.headline3(String text,
          {Key? key,
          Color? fontColor,
          double? fontSize,
          FontWeight? fontWeight,
          String? fontFamily,
          TextAlign? textAlign,
          int? maxLines,
          TextDecoration? decoration}) =>
      QcText(text,
          key: key,
          textStyle: Get.theme.textTheme.headline3,
          fontColor: fontColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: fontFamily,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration);

  /**
   * GNB 타이틀 사이즈
   */
  factory QcText.headline6(String text,
          {Key? key,
          Color? fontColor,
          double? fontSize,
          FontWeight? fontWeight,
          String? fontFamily,
          TextAlign? textAlign,
          int? maxLines,
          TextDecoration? decoration}) =>
      QcText(text,
          key: key,
          textStyle: Get.theme.textTheme.headline6,
          fontColor: fontColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: fontFamily,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration);

  factory QcText.subtitle1(String text,
          {Key? key,
          Color? fontColor,
          double? fontSize,
          FontWeight? fontWeight,
          String? fontFamily,
          TextAlign? textAlign,
          int? maxLines,
          TextDecoration? decoration}) =>
      QcText(text,
          key: key,
          textStyle: Get.theme.textTheme.subtitle1,
          fontColor: fontColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: fontFamily,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration);

  factory QcText.bodyText1(String text,
          {Key? key,
          Color? fontColor,
          double? fontSize,
          FontWeight? fontWeight,
          String? fontFamily,
          TextAlign? textAlign,
          int? maxLines,
          TextDecoration? decoration}) =>
      QcText(text,
          key: key,
          textStyle: Get.theme.textTheme.bodyText1,
          fontColor: fontColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: fontFamily,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration);

  factory QcText.caption(String text,
          {Key? key,
          Color? fontColor,
          double? fontSize,
          FontWeight? fontWeight,
          String? fontFamily,
          TextAlign? textAlign,
          int? maxLines,
          TextDecoration? decoration}) =>
      QcText(text,
          key: key,
          textStyle: Get.theme.textTheme.caption,
          fontColor: fontColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: fontFamily,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration);
}
