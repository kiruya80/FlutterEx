import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/focus_manager.dart';
import 'package:flutterex/controllers/base_controller.dart';
import 'package:flutterex/firebase/auth_exception.dart';
import 'package:flutterex/firebase/firebase_auth_utils.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:flutterex/widget/dialog_widget.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

///
/// https://firebase.google.com/docs/auth/flutter/federated-auth
///
/// 샘플
/// https://github.com/firebase/flutterfire/tree/master/packages/firebase_auth/firebase_auth/example/lib
///
/// https://pub.dev/packages/flutter_signin_button
///
class FireAuthController extends BaseController {
  var userCredential = ''.obs;
  var isObscureText = true.obs;

  @override
  void init() {
    super.init();

    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        QcLog.e('FirebaseAuth user : $user');

        ///  user = FirebaseAuth.instance.currentUser!;
        userCredential.value = 'Sign In : ' + user.toString();

        /// Anonymously
        /// FirebaseAuth user : User(displayName: null, email: null, emailVerified: false, isAnonymous: true,
        /// metadata: UserMetadata(creationTime: 2022-06-16 15:38:42.049, lastSignInTime: 2022-06-16 15:38:42.049), phoneNumber: null, photoURL: null, providerData,
        /// [], refreshToken: , tenantId: null, uid: 0Wy5wOSxZ3R7MjPTCjgtND0zbAy2)

        /// email sign in
        /// FirebaseAuth user : User(displayName: null, email: hfhfhhg@huu.mji, emailVerified: false, isAnonymous: false,
        /// metadata: UserMetadata(creationTime: 2022-06-17 16:28:22.556, lastSignInTime: 2022-06-17 16:28:22.556), phoneNumber: null, photoURL: null, providerData,
        /// [UserInfo(displayName: null, email: hfhfhhg@huu.mji, phoneNumber: null, photoURL: null, providerId: password, uid: hfhfhhg@huu.mji)], refreshToken: ,
        /// tenantId: null, uid: N3P9YEXu8mUqDMOcWy2jAdNS1eu1)

        /// email log in
        /// FirebaseAuth user : User(displayName: null, email: hfhfhhg@huu.mji, emailVerified: false, isAnonymous: false,
        /// metadata: UserMetadata(creationTime: 2022-06-17 16:28:22.556, lastSignInTime: 2022-06-17 16:33:18.320), phoneNumber: null, photoURL: null, providerData,
        /// [UserInfo(displayName: null, email: hfhfhhg@huu.mji, phoneNumber: null, photoURL: null, providerId: password, uid: hfhfhhg@huu.mji)], refreshToken: ,
        /// tenantId: null, uid: N3P9YEXu8mUqDMOcWy2jAdNS1eu1)

        /// google
        /// FirebaseAuth user : User(displayName: 김웅진, email: wjdev.iosdev.004@gmail.com, emailVerified: true, isAnonymous: false,
        /// metadata: UserMetadata(creationTime: 2022-06-16 15:03:51.901, lastSignInTime: 2022-06-16 15:03:51.901), phoneNumber: null,
        /// photoURL: https://lh3.googleusercontent.com/a/AATXAJzZmiYnMwnEH_GZulUPsYyIuhe3xNwfibcvOXn4=s96-c, providerData,
        /// [UserInfo(displayName: 김웅진, email: wjdev.iosdev.004@gmail.com, phoneNumber: null,
        /// photoURL: https://lh3.googleusercontent.com/a/AATXAJzZmiYnMwnEH_GZulUPsYyIuhe3xNwfibcvOXn4=s96-c, providerId: google.com, uid: 109492054029226968010)],
        /// refreshToken: , tenantId: null, uid: pToTGwTyQyNYUlCMXHGAdn6PlCA3)
      } else {
        userCredential.value = 'Sign Out';
      }
    });
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  void anonymousAuth() {
    FirebaseAuthUtils.instance.anonymousAuth().then((value) {
      QcLog.e('anonymousAuth : $value');
      QcDialog.dissmissProgress();

      /// UserCredential(additionalUserInfo: AdditionalUserInfo(isNewUser: true, profile: {}, providerId: null, username: null), credential: null,
      /// user: User(displayName: null, email: null, emailVerified: false, isAnonymous: true, metadata: UserMetadata(creationTime: 2022-06-16 15:38:42.049, lastSignInTime: 2022-06-16 15:38:42.049), phoneNumber: null, photoURL: null, providerData, [], refreshToken: , tenantId: null, uid: 0Wy5wOSxZ3R7MjPTCjgtND0zbAy2))
      ///
    }).catchError((error) {
      QcLog.e('error: $error');
      QcDialog.showMsg(title: 'notice'.tr, msg: error);
    });
  }

  bool checkIdPwd(FocusNode emailFocusNode, String emailAddress,
      FocusNode pwdFocusNode, String password) {
    if (emailAddress.isEmpty || !emailAddress.isEmail) {
      Fluttertoast.showToast(
          msg: 'Email형식으로 입력해주세요',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
      // FocusScope.of(context).requestFocus(emailFocusNode)
      emailFocusNode.requestFocus();
      return false;
    }
    if (password.isEmpty || password.length < 6) {
      Fluttertoast.showToast(
          msg: '패스워드는 6자리 이상 입력해주세요',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
      pwdFocusNode.requestFocus();
      return false;
    }
    return true;
  }

  void createUserWithEmailAndPassword(String emailAddress, String password) {
    FirebaseAuthUtils.instance
        .createUserWithEmailAndPassword(
            AuthMode.SIGN_UP, emailAddress, password)
        .then((value) {
      QcLog.e('createUserWithEmailAndPassword : $value');

      /// signInWithEmail : UserCredential(additionalUserInfo: AdditionalUserInfo(isNewUser: true, profile: {}, providerId: null, username: null), credential: null,
      /// user: User(displayName: null, email: hfhfhhg@huu.mji, emailVerified: false, isAnonymous: false,
      /// metadata: UserMetadata(creationTime: 2022-06-17 16:28:22.556, lastSignInTime: 2022-06-17 16:28:22.556), phoneNumber: null, photoURL: null, providerData,
      /// [UserInfo(displayName: null, email: hfhfhhg@huu.mji, phoneNumber: null, photoURL: null, providerId: password, uid: hfhfhhg@huu.mji)], refreshToken: , tenantId: null, uid: N3P9YEXu8mUqDMOcWy2jAdNS1eu1))
    }).catchError((error) {
      QcLog.e('error: $error');
      String errorMsg = error.toString();
      if (error is FirebaseAuthException) {
        // var fireError =  error as FirebaseAuthException;
        var fireError = error;
        QcLog.e(
            'fireError :, ${fireError.plugin} , ${fireError.code} , ${fireError.message}');

        errorMsg = FireAuthException.getErrorMsg(fireError.code);
      }

      QcDialog.showMsg(title: 'notice'.tr, msg: errorMsg);
    });
  }

  void signInWithEmailAndPassword(String emailAddress, String password) {
    FirebaseAuthUtils.instance
        .signInWithEmailAndPassword(AuthMode.SIGN_UP, emailAddress, password)
        .then((value) {
      QcLog.e('signInWithEmailAndPassword : $value');

      /// signInWithEmail : UserCredential(additionalUserInfo: AdditionalUserInfo(isNewUser: true, profile: {}, providerId: null, username: null), credential: null,
      /// user: User(displayName: null, email: hfhfhhg@huu.mji, emailVerified: false, isAnonymous: false,
      /// metadata: UserMetadata(creationTime: 2022-06-17 16:28:22.556, lastSignInTime: 2022-06-17 16:28:22.556), phoneNumber: null, photoURL: null, providerData,
      /// [UserInfo(displayName: null, email: hfhfhhg@huu.mji, phoneNumber: null, photoURL: null, providerId: password, uid: hfhfhhg@huu.mji)], refreshToken: , tenantId: null, uid: N3P9YEXu8mUqDMOcWy2jAdNS1eu1))
    }).catchError((error) {
      QcLog.e('error: $error');
      String errorMsg = error.toString();
      if (error is FirebaseAuthException) {
        // var fireError =  error as FirebaseAuthException;
        var fireError = error;
        QcLog.e(
            'fireError :, ${fireError.plugin} , ${fireError.code} , ${fireError.message}');
        errorMsg = FireAuthException.getErrorMsg(fireError.code);
        if ("user-not-found" == fireError.code) {
          /// 회원가입 유도
          errorMsg =
              errorMsg + '\n\n ${emailAddress}\n' + 'msg_sign_up_email'.tr;
        }
      }

      /// 회원이 아닌 경우 회원가입 유도 팝업
      QcDialog.showMsgTwoBtn(
          title: 'notice'.tr,
          content: QcText.bodyText1('$errorMsg'),
          lBtnStr: 'cancel'.tr,
          rBtnStr: 'ok'.tr,
          callback: (idx) {
            if (idx == DialogBtn.RIGHT) {
              createUserWithEmailAndPassword(emailAddress, password);
            }
          });
    });
  }

  void signInWithGoogle() {
    FirebaseAuthUtils.instance.signInWithGoogle().then((value) {
      QcLog.e('anonymousAuth : $value');

      /// UserCredential(additionalUserInfo: AdditionalUserInfo(isNewUser: false, profile: {given_name: 웅진, locale: ko, family_name: 김,
      /// picture: https://lh3.googleusercontent.com/a/AATXAJzZmiYnMwnEH_GZulUPsYyIuhe3xNwfibcvOXn4=s96-c, aud: 656621123867-fmpg2hup4fj6ko27pctkru5bp7hv4idg.apps.googleusercontent.com,
      /// azp: 656621123867-l5k7l2udh06907oocnha0bkirafm8h71.apps.googleusercontent.com, exp: 1655797854, iat: 1655794254, iss: https://accounts.google.com, sub: 109492054029226968010, name: 김웅진, email: wjdev.iosdev.004@gmail.com, email_verified: true},
      /// providerId: google.com, username: null), credential: AuthCredential(providerId: google.com, signInMethod: google.com, token: null),
      /// user: User(displayName: 김웅진, email: wjdev.iosdev.004@gmail.com, emailVerified: true, isAnonymous: false,
      /// metadata: UserMetadata(creationTime: 2022-06-16 15:04:12.849, lastSignInTime: 2022-06-21 16:31:50.753), phoneNumber: null, photoURL: https://lh3.googleusercontent.com/a/AATXAJzZmiYnMwnEH_GZul
      ///
    }).catchError((error) {
      QcLog.e('error: $error');
      QcDialog.showMsg(title: 'notice'.tr, msg: error);
    });
  }

  void signInWithFacebook() {}

  void signInWithApple() {}
}
