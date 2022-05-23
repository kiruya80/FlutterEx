import 'dart:convert';

class HomeItem {
  String name;
  String routeName;
  String icon;

  HomeItem({
    required this.name,
    required this.routeName,
    required this.icon,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'routeName': routeName,
      'icon': icon,
    };
  }

  factory HomeItem.fromMap(Map<String, dynamic> map) {
    return HomeItem(
      name: map['name'],
      routeName: map['routeName'],
      icon: map['icon'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeItem.fromJson(String source) =>
      HomeItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HomeItem{name: $name, routeName: $routeName, icon: $icon}';
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
