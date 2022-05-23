import 'dart:convert';

import 'dart:ui';

import 'package:flutter/src/painting/text_style.dart';

class FontItem {
  TextStyle? textStyle;

  String styleName;

  FontItem({
    required this.textStyle,
    required this.styleName,
  });

  Map<String, dynamic> toMap() {
    return {
      'textStyle': textStyle,
      'styleName': styleName,
    };
  }

  factory FontItem.fromMap(Map<String, dynamic> map) {
    return FontItem(
      textStyle: map['textStyle'],
      styleName: map['styleName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FontItem.fromJson(String source) =>
      FontItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FontItem{textStyle: $textStyle , styleName: $styleName}';
  }
}

// // nanum_square_round_otf_light
// factory MCText.nsrl(String text,
// {Key? key,
//     Color? fontColor,
// double? fontSize,
//     String? fontFamily,
// TextAlign? textAlign,
// int? maxLine,
//     TextDecoration? decoration}) =>
// MCText(text,
// key: key,
// fontColor: fontColor,
// fontSize: fontSize,
// fontWeight: FontWeight.w400,
// fontFamily: "NanumSquare",
// textAlign: textAlign,
// maxLine: maxLine,
// decoration: decoration);
