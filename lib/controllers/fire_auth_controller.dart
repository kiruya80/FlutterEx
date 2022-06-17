import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterex/controllers/base_controller.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:flutterex/widget/dialog_widget.dart';
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

  // GoogleSignIn _googleSignIn = GoogleSignIn(
  //   // Optional clientId
  //   // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  //   scopes: <String>[
  //     'email',
  //     'https://www.googleapis.com/auth/contacts.readonly',
  //   ],
  // );

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  Future<UserCredential> anonymousAuth() async {
    QcDialog.showProgress();
    var result;

    try {
      result = await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      QcLog.e('FirebaseAuthException error : $e');
    } catch (e) {
      QcLog.e('FirebaseAuthException catch : $e');
    } finally {
      QcDialog.dissmissProgress();
    }
    return result;
  }

  Future<UserCredential> signInWithEmail(
      String emailAddress, String password) async {
    QcDialog.showProgress();
    return await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress, password: password);
  }

  Future<UserCredential> signInWithEmailAndPassword(
      String emailAddress, String password) async {
    QcDialog.showProgress();
    return await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailAddress, password: password);
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    QcLog.e('googleUser : $googleUser');

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    QcLog.e('googleAuth : $googleAuth');

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    QcLog.e('credential : $credential');

    // Once signed in, return the UserCredential
    QcDialog.showProgress();
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // Future<void> _signInWithGoogle() async {
  //   setIsLoading();
  //   try {
  //     // Trigger the authentication flow
  //     final googleUser = await GoogleSignIn().signIn();
  //
  //     // Obtain the auth details from the request
  //     final googleAuth = await googleUser?.authentication;
  //
  //     if (googleAuth != null) {
  //       // Create a new credential
  //       final credential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth.accessToken,
  //         idToken: googleAuth.idToken,
  //       );
  //
  //       // Once signed in, return the UserCredential
  //       await _auth.signInWithCredential(credential);
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     setState(() {
  //       error = '${e.message}';
  //     });
  //   } finally {
  //     setIsLoading();
  //   }
  // }

  ///
  /// facebook login
  ///
  // Future<UserCredential> signInWithFacebook() async {
  //   // Trigger the sign-in flow
  //   final LoginResult loginResult = await FacebookAuth.instance.login();
  //
  //   // Create a credential from the access token
  //   final OAuthCredential facebookAuthCredential =
  //       FacebookAuthProvider.credential(loginResult.accessToken.token);
  //
  //   // Once signed in, return the UserCredential
  //   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  // }

  // String validatePassword(FocusNode focusNode, String value){
  //   if(value.isEmpty){
  //     focusNode.requestFocus();
  //     return '비밀번호를 입력하세요.';
  //   }else {
  //     Pattern pattern = r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,15}$';
  //     RegExp regExp = new RegExp(pattern);
  //     if(!regExp.hasMatch(value)){
  //       focusNode.requestFocus();
  //       return '특수문자, 대소문자, 숫자 포함 8자 이상 15자 이내로 입력하세요.';
  //     }else{
  //       return null;
  //     }
  //   }
  // }

  /// google user photo
  // Future<String?> getPhotoURLFromUser() async {
  //   String? photoURL;
  //
  //   // Update the UI - wait for the user to enter the SMS code
  //   await showDialog<String>(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: const Text('New image Url:'),
  //         actions: [
  //           ElevatedButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('Update'),
  //           ),
  //           OutlinedButton(
  //             onPressed: () {
  //               photoURL = null;
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('Cancel'),
  //           ),
  //         ],
  //         content: Container(
  //           padding: const EdgeInsets.all(20),
  //           child: TextField(
  //             onChanged: (value) {
  //               photoURL = value;
  //             },
  //             textAlign: TextAlign.center,
  //             autofocus: true,
  //           ),
  //         ),
  //       );
  //     },
  //   );
  //
  //   return photoURL;
  // }
}
