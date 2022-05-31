import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ko_KR': {
          'greeting': '안녕',
          'title_main': 'Flutter Sample',
          'title_font': '폰트',
          'title_widget': '위젯',
          'title_image': '이미지',
          'title_loading_widget': '로딩 위젯',
          'title_multi_lang': '다국어',
          'title_permission': '권한',
          'title_web_print': '웹 프린트',
          'title_http_api': 'Api Http 샘플',
          'title_dio_api': 'Api Dio 샘플',
          'title_sqllite_db': 'Sqlite db 샘플',
          'title_firebase_crashlytics': 'Crashlytics 샘플',
          'title_firebase_storage': 'Storage 샘플',
          'title_firebase_messaging': 'Push 샘플',
          'theme_light': 'Light 테마',
          'theme_dark': 'Dark 테마',
          'api_get_posts': 'GET	/posts',
          'api_get_posts_1': 'GET	/posts/1',
          'api_get_comments': 'GET	/posts/1/comments',
          'api_get_comments_1': 'GET	/comments?postId=1',
          'api_post_posts': 'POST	/posts',
          'api_put_posts': 'PUT	/posts/1',
          'api_patch_posts': 'PATCH	/posts/1',
          'api_delete_posts': 'DELETE	/posts/1',
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
