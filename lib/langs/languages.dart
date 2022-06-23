import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ko_KR': {
          'greeting': '안녕',
          'notice': '알림',
          'ok': '확인',
          'close': '닫기',
          'cancel': '취소',
          'title_main': 'Flutter Sample',
          'title_font': '폰트',
          'title_widget': '위젯',
          'title_image': '이미지',
          'title_loading_widget': '로딩 위젯',
          'title_tran': 'Page 이동 애니메이션',
          'title_multi_lang': '다국어',
          'title_permission': '권한',
          'title_web_print': '웹 프린트',
          'title_http_api': 'Api Http 샘플',
          'title_dio_api': 'Api Dio 샘플',
          'title_sqllite_db': 'Sqlite db 샘플',
          'title_firebase_auth': 'firebase Auth 샘플',
          'title_firebase_storage': 'firebase Storage 샘플',
          'title_firebase_database': 'firebase Database 샘플',
          'title_firebase_messaging': 'firebase FCM 샘플',
          'title_firebase_app_check': 'firebase AppCheck 샘플',
          'title_firebase_crashlytics': 'firebase Crashlytics 샘플',
          'title_firebase_analytics': 'firebase Analytics 샘플',
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
          'msg_sign_up_email': '해당 이메일로 회원가입을 하시겠습니까?',
          'fire_auth_error_invalid_email':
              'email 사용자 속성에 제공된 값이 잘못되었습니다. 이 값은 문자열 이메일 주소여야 합니다.',
          'fire_auth_error_user_disabled': '이메일에 해당하는 사용자가 비활성화되었습니다.',
          'fire_auth_error_user_not_found': '이메일에 해당하는 사용자가 없습니다.',
          'fire_auth_error_wrong_password':
              '주어진 이메일에 대한 비밀번호가 유효하지 않거나 이메일에 해당하는 계정에 비밀번호가 설정되지 않았습니다.',
          'fire_auth_error_email_already_in_use': '해당 이메일은 이미 가입되어 있습니다.',
          'fire_auth_error_account_exists_with_different_credential':
              '이메일 주소는 같지만 로그인 자격 증명이 다른 계정이 이미 존재합니다. 이 이메일 주소와 연결된 제공업체를 사용하여 로그인합니다.',
          'fire_auth_error_invalid_credential': '자격 증명의 형식이 잘못되었거나 만료되었습니다.',
          'fire_auth_error_operation_not_allowed': '회원가입이 허용되지 않은 계정 유형입니다.',
          'fire_auth_error_invali_dverification_code':
              '자격 증명의 인증 코드가 유효하지 않습니다.',
          'fire_auth_error_invalid_verification_id': '자격 증명의 확인 ID가 유효하지 않습니다.',
        },
        'en_US': {
          'greeting': 'Hello',
          'notice': 'Notice',
          'ok': 'OK',
          'close': 'CLOSE',
          'cancel': 'CANCEL',
          'fire_auth_error_invalid_email': 'The email address is not valid.',
          'fire_auth_error_user_disabled':
              'The user corresponding to the given email has been disabled.',
          'fire_auth_error_user_not_found':
              'There is no user corresponding to the given email.',
          'fire_auth_error_wrong_password':
              'The password is invalid for the given email, or the account corresponding to the email does not have a password set.',
          'fire_auth_error_email_already_in_use': '해당 이메일은 이미 가입되어 있습니다.',
          'fire_auth_error_account_exists_with_different_credential':
              'An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address.',
          'fire_auth_error_invalid_credential':
              'The credential is malformed or has expired.',
          'fire_auth_error_operation_not_allowed':
              'The type of account corresponding to the credential is not enabled.',
          'fire_auth_error_invali_dverification_code':
              'Credential and the verification code of the credential is not valid.',
          'fire_auth_error_invalid_verification_id':
              'Credential and the verification ID of the credential is not valid.',
        },
        'ja_JP': {
          'greeting': 'こんにちは',
          // 'multi_title': '다국어 일본',
        },
      };
}
