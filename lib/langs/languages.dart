import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ko_KR': {
          'greeting': '안녕',
          'title_main': 'Flutter Sample',
          'title_font': '폰트',
          'title_widget': '위젯',
          'title_multi_lang': '다국어',
          'title_permission': '권한',
          'title_web_print': '웹 프린트',
        },
        'en_US': {
          'greeting': 'Hello',
        },
        'ja_JP': {
          'greeting': 'こんにちは',
          // 'multi_title': '다국어 일본',
        },
      };
}
