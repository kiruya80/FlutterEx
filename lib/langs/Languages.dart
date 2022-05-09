import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ko_KR': {
          'greeting': '안녕하세요',
          'multi_title': '다국어',
        },
        'en_US': {
          'greeting': 'Hello',
          // 'multi_title': '다국어 영어',
        },
        'ja_JP': {
          'greeting': 'こんにちは',
          // 'multi_title': '다국어 일본',
        },
      };
}
