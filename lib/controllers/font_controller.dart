import 'package:flutterex/controllers/base_controller.dart';
import 'package:flutterex/datas/model/font_item.dart';
import 'package:get/get.dart';

class FontController extends BaseController {
  List<FontItem> fontItems = [];

  Future<List<FontItem>> makeFontData() async {
    fontItems = [];
    fontItems.add(FontItem(
        textStyle: Get.theme.textTheme.headline1,
        styleName: '헤드라인 headline 1'));
    fontItems.add(FontItem(
        textStyle: Get.theme.textTheme.headline2,
        styleName: '헤드라인 headline 2'));
    fontItems.add(FontItem(
        textStyle: Get.theme.textTheme.headline3,
        styleName: '헤드라인 headline 3'));
    fontItems.add(FontItem(
        textStyle: Get.theme.textTheme.headline4,
        styleName: '헤드라인 headline 4'));
    fontItems.add(FontItem(
        textStyle: Get.theme.textTheme.headline5,
        styleName: '헤드라인 headline 5'));
    fontItems.add(FontItem(
        textStyle: Get.theme.textTheme.headline6,
        styleName: '헤드라인 headline 6'));

    fontItems.add(FontItem(
        textStyle: Get.theme.textTheme.subtitle1,
        styleName: '서브타이틀 subtitle 1'));
    fontItems.add(FontItem(
        textStyle: Get.theme.textTheme.subtitle2,
        styleName: '서브타이틀 subtitle 2'));

    fontItems.add(FontItem(
        textStyle: Get.theme.textTheme.bodyText1,
        styleName: '바디텍스트 bodyText 1'));
    fontItems.add(FontItem(
        textStyle: Get.theme.textTheme.bodyText2,
        styleName: '바디텍스트 bodyText 2'));

    fontItems.add(FontItem(
        textStyle: Get.theme.textTheme.caption, styleName: '캡션 caption'));
    fontItems.add(FontItem(
        textStyle: Get.theme.textTheme.button, styleName: '버튼 button'));
    fontItems.add(FontItem(
        textStyle: Get.theme.textTheme.overline, styleName: '오버라인 overline'));

    return fontItems;
  }
}
