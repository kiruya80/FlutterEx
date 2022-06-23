/// 가입 타입
enum Provider { PHONE, EMAIL, GOOGLE, FACEBOOK, APPLE }

extension HelloExtension on Provider {
  String get convertedKorText {
    switch (this) {
      case Provider.PHONE:
        return "";
      case Provider.EMAIL:
        return "password";
      case Provider.GOOGLE:
        return "google.com";
      case Provider.FACEBOOK:
        return "facebook.com";
      case Provider.APPLE:
        return "apple.com";
      default:
        return "";
    }
  }
}
