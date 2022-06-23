import 'package:get/get.dart';

class FireAuthException {
  ///
  /// https://firebase.google.com/docs/reference/js/v8/firebase.auth.Auth#signinwithcredential
  ///
  /// https://firebase.flutter.dev/docs/auth/usage/
  ///
  static String getErrorMsg(String code) {
    String errorMessage = '';
    switch (code) {
      // signInWithEmailAndPassword , createUserWithEmailAndPassword
      case "invalid-email":
        errorMessage = 'fire_auth_error_invalid_email'.tr;
        break;
      case "user-disabled":
        errorMessage = 'fire_auth_error_user_disabled'.tr;
        break;
      case "user-not-found":
        errorMessage = 'fire_auth_error_user_not_found'.tr;
        break;

      /// wrong-password : 구글, 페이스북에 가입된 이메일인 경우 이렇게 에러가 나온다
      case "wrong-password":
        errorMessage = 'fire_auth_error_wrong_password'.tr;
        break;

      /// 구글, 페이스북에 가입된 이메일인 경우 에러처리됨
      case "email-already-in-use":
        errorMessage = 'fire_auth_error_wrong_password'.tr;
        break;

      // signInWithCredential
      case "account-exists-with-different-credential":
        // 이메일 주소는 같지만 로그인 자격 증명이 다른 계정이 이미 존재합니다. 이 이메일 주소와 연결된 제공업체를 사용하여 로그인합니다.
        errorMessage =
            'fire_auth_error_account_exists_with_different_credential'.tr;
        break;
      case "invalid-credential":
        errorMessage = 'fire_auth_error_invalid_credential'.tr;
        break;
      case "operation-not-allowed":
        errorMessage = 'fire_auth_error_operation_not_allowed'.tr;
        break;
      // case "user-disabled":
      //   errorMessage = 'fire_auth_error_user_disabled'.tr;
      //   break;
      // case "user-not-found":
      //   errorMessage = 'fire_auth_error_user_not_found'.tr;
      //   break;
      // case "wrong-password":
      //   errorMessage = 'fire_auth_error_wrong_password'.tr;
      //   break;
      case "invalid-verification-code":
        errorMessage = 'fire_auth_error_invali_dverification_code'.tr;
        break;
      case "invalid-verification-id":
        errorMessage = 'fire_auth_error_invalid_verification_id'.tr;
        break;

      default:
        errorMessage = "An undefined Error happened.";
    }

    return errorMessage;
  }
}
