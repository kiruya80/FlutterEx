import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/focus_manager.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutterex/controllers/base_controller.dart';
import 'package:flutterex/firebase/auth_exception.dart';
import 'package:flutterex/firebase/firebase_auth_utils.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:flutterex/widget/dialog_widget.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
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

        /// facebook
        /// FirebaseAuth user : User(displayName: 김웅진, email: wjdev.iosdev.004@gmail.com, emailVerified: false, isAnonymous: false,
        /// metadata: UserMetadata(creationTime: 2022-06-22 15:48:51.264, lastSignInTime: 2022-06-22 15:48:51.265), phoneNumber: null,
        /// photoURL: https://graph.facebook.com/109825618435551/picture, providerData,
        /// [UserInfo(displayName: 김웅진, email: wjdev.iosdev.004@gmail.com, phoneNumber: null,
        /// photoURL: https://graph.facebook.com/109825618435551/picture, providerId: facebook.com, uid: 109825618435551)], refreshToken: ,
        /// tenantId: null, uid: 4zzw6Q3C1KYgTFOmwfHm24M5mFC3)
        ///
      } else {
        userCredential.value = 'Sign Out';
      }
    });
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
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

  bool checkEmail(FocusNode emailFocusNode, String emailAddress) {
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
    return true;
  }

  bool checkPwd(FocusNode pwdFocusNode, String password) {
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

      ///
      /// 페이스북 같은 이메일이 존재하는데 가입하는 경우
      ///  error: [firebase_auth/email-already-in-use] The email address is already in use by another account.
      ///
      ///  이메일로 가입되어있는 상태에서 이메일 가입을 선택한 경우로 비번확인 알림과 비번 리셋유도
      /// error: [firebase_auth/email-already-in-use] The email address is already in use by another account.
      ///
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

      /// 페이스북 같은 이메일이 존재하는데 로그인하는 경우
      /// error: [firebase_auth/wrong-password] The password is invalid or the user does not have a password.
      ///
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

  void fetchSignInMethodsForEmail(String emailAddress) {
    FirebaseAuthUtils.instance
        .fetchSignInMethodsForEmail(emailAddress)
        .then((providerList) {
      QcLog.e('fetchSignInMethodsForEmail : $providerList');
    }).catchError((error) {
      QcLog.e('error: $error');
    });
  }

  void signInWithGoogle() {
    FirebaseAuthUtils.instance.signInWithGoogle().then((value) {
      QcLog.e('signInWithGoogle : $value');

      // providerData ==  [UserInfo(displayName: 김웅진,
      // email: wjdev.iosdev.004@gmail.com, phoneNumber: null,
      // photoURL: https://lh3.googleusercontent.com/a/AATXAJzZmiYnMwnEH_GZulUPsYyIuhe3xNwfibcvOXn4=s96-c,
      // providerId: google.com, uid: 109492054029226968010)]
      QcLog.e('providerData ==  ${value.user?.providerData.toString()}');

      /// UserCredential(additionalUserInfo: AdditionalUserInfo(isNewUser: false, profile: {given_name: 웅진, locale: ko, family_name: 김,
      /// picture: https://lh3.googleusercontent.com/a/AATXAJzZmiYnMwnEH_GZulUPsYyIuhe3xNwfibcvOXn4=s96-c, aud: 656621123867-fmpg2hup4fj6ko27pctkru5bp7hv4idg.apps.googleusercontent.com,
      /// azp: 656621123867-l5k7l2udh06907oocnha0bkirafm8h71.apps.googleusercontent.com, exp: 1655797854, iat: 1655794254, iss: https://accounts.google.com, sub: 109492054029226968010, name: 김웅진, email: wjdev.iosdev.004@gmail.com, email_verified: true},
      /// providerId: google.com, username: null), credential: AuthCredential(providerId: google.com, signInMethod: google.com, token: null),
      /// user: User(displayName: 김웅진, email: wjdev.iosdev.004@gmail.com, emailVerified: true, isAnonymous: false,
      /// metadata: UserMetadata(creationTime: 2022-06-16 15:04:12.849, lastSignInTime: 2022-06-21 16:31:50.753), phoneNumber: null, photoURL: https://lh3.googleusercontent.com/a/AATXAJzZmiYnMwnEH_GZul
      ///
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

  void signInWithFacebook() {
    FirebaseAuthUtils.instance.signInWithFacebook().whenComplete(() {
      QcLog.e('whenComplete');
    })
        // .onError((error, stackTrace) {
        //   QcLog.e('error $error');
        // })
        .then((value) {
      QcLog.e('signInWithFacebook : $value');
      // value.user.linkWithCredential(credential)
      // value.user.unlink(providerId)

      /// UserCredential(additionalUserInfo: AdditionalUserInfo(isNewUser: true, profile: {picture:
      /// {data: {height: 100, url: https://scontent-dfw5-1.xx.fbcdn.net/v/t1.30497-1/84628273_176159830277856_972693363922829312_n.jpg?stp=c29.0.100.100a_dst-jpg_p100x100&_nc_cat=1&ccb=1-7&_nc_sid=12b3be&_nc_ohc=znOHiwVT5CwAX_xPYWE&_nc_ht=scontent-dfw5-1.xx&edm=AP4hL3IEAAAA&oh=00_AT8B0nbJdXgRlm7s03Wa1kcDtan8dPLszZFieRjSkL58Cg&oe=62D83899, width: 100, is_silhouette: true}},
      /// first_name: 웅진, id: 109825618435551, name: 김웅진, email: wjdev.iosdev.004@gmail.com, last_name: 김}, providerId: facebook.com, username: null),
      /// credential: AuthCredential(providerId: facebook.com, signInMethod: facebook.com, token: null), user: User(displayName: 김웅진, email: wjdev.iosdev.004@gmail.com,
      /// emailVerified: false, isAnonymous: false, metadata: UserMetadata(creationTime: 2022-06-22 15:48:51.264, lastSignInTime: 2022-06-22 15:48:51.265), phoneNumber: null, photoURL: https://graph.facebook.com/1098256184
    }).catchError((error) async {
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

      User? user = FirebaseAuth.instance.currentUser;
      QcLog.e('user : $user');
      QcLog.e('user : ${user.toString()}');
    });
  }

  void signInWithApple() {}
}
