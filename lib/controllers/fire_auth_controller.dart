import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterex/controllers/base_controller.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:flutterex/widget/dialog_widget.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

///
/// https://firebase.google.com/docs/auth/flutter/federated-auth
///
class FireAuthController extends BaseController {
  var userCredential = ''.obs;

  @override
  void init() {
    super.init();

    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        QcLog.e('FirebaseAuth user : $user');
        userCredential.value = 'Sign In : ' + user.toString();

        /// Anonymously
        /// FirebaseAuth user : User(displayName: null, email: null, emailVerified: false, isAnonymous: true,
        /// metadata: UserMetadata(creationTime: 2022-06-16 15:38:42.049, lastSignInTime: 2022-06-16 15:38:42.049), phoneNumber: null, photoURL: null, providerData,
        /// [], refreshToken: , tenantId: null, uid: 0Wy5wOSxZ3R7MjPTCjgtND0zbAy2)

        /// google
        /// FirebaseAuth user : User(displayName: 김웅진, email: wjdev.iosdev.004@gmail.com, emailVerified: true, isAnonymous: false,
        /// metadata: UserMetadata(creationTime: 2022-06-16 15:03:51.901, lastSignInTime: 2022-06-16 15:03:51.901), phoneNumber: null, photoURL: https://lh3.googleusercontent.com/a/AATXAJzZmiYnMwnEH_GZulUPsYyIuhe3xNwfibcvOXn4=s96-c, providerData,
        /// [UserInfo(displayName: 김웅진, email: wjdev.iosdev.004@gmail.com, phoneNumber: null, photoURL: https://lh3.googleusercontent.com/a/AATXAJzZmiYnMwnEH_GZulUPsYyIuhe3xNwfibcvOXn4=s96-c, providerId: google.com, uid: 109492054029226968010)],
        /// refreshToken: , tenantId: null, uid: pToTGwTyQyNYUlCMXHGAdn6PlCA3)
      } else {
        userCredential.value = 'Sign Out';
      }
    });
  }

  GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<UserCredential> anonymously() async {
    // try {
    //   return    await FirebaseAuth.instance.signInAnonymously();
    // } on FirebaseAuthException catch (e) {
    //   switch (e.code) {
    //     case "operation-not-allowed":
    //       print("Anonymous auth hasn't been enabled for this project.");
    //       break;
    //     default:
    //       print("Unknown error.");
    //   }
    // }

    QcDialog.showProgress();
    return await FirebaseAuth.instance.signInAnonymously();
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
}
