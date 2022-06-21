import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:flutterex/widget/dialog_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// The mode of the current auth session, either [AuthMode.login] or [AuthMode.register].
// ignore: public_member_api_docs
enum AuthMode { SIGN_IN, SIGN_UP, PHONE }

class FirebaseAuthUtils {
  static FirebaseAuthUtils get instance {
    return FirebaseAuthUtils();
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

    try {
      return await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    } finally {
      QcDialog.dissmissProgress();
    }
  }

  // Future<UserCredential> createWithEmail(
  //     String emailAddress, String password) async {
  //   QcDialog.showProgress();
  //   return await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: emailAddress, password: password);
  // }

  Future<UserCredential> createUserWithEmailAndPassword(
      AuthMode mode, String emailAddress, String password) async {
    QcDialog.showProgress();

    try {
      // 회원가입
      return await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      // return Future.error(e.code);
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
      // throw FireException(errorMessage: "Unknown Error");
      // QcDialog.showMsg(e);
    } finally {
      QcLog.e('finally : ');
      QcDialog.dissmissProgress();
    }
  }

  Future<UserCredential> signInWithEmailAndPassword(
      AuthMode mode, String emailAddress, String password) async {
    QcDialog.showProgress();
    // return await FirebaseAuth.instance
    //     .signInWithEmailAndPassword(email: emailAddress, password: password);

    try {
      // 로그인
      return await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      // return Future.error(e.code);
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
      // throw FireException(errorMessage: "Unknown Error");
      // QcDialog.showMsg(e);
    } finally {
      QcLog.e('finally : ');
      QcDialog.dissmissProgress();
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // QcDialog.showProgress();

    try {
      // Trigger the authentication flow
      final googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final googleAuth = await googleUser?.authentication;

      if (googleAuth != null) {
        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        QcDialog.showProgress();
        // Once signed in, return the UserCredential
        return await FirebaseAuth.instance.signInWithCredential(credential);
      }
      return Future.error('구글 계정을 선택하거나 구글 로그인을 해주세요.');
    } on FirebaseAuthException catch (e) {
      QcLog.e('FirebaseAuthException : $e');
      return Future.error(e);
    } catch (e) {
      QcLog.e('catch : $e');
      return Future.error(e);
    } finally {
      QcLog.e('finally : ');
      QcDialog.dissmissProgress();
    }
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
//       FacebookAuthProvider.credential(loginResult.accessToken?.token);
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

  ///
  /// account-exists-with-different-credential오류 처리
// Firebase 콘솔 에서 이메일 주소당 하나의 계정 설정을 활성화한 경우
// 사용자가 다른 Firebase 사용자의 제공자(예: Facebook)에 대해 이미 존재하는 이메일로 제공자(예: Google)에 로그인을 시도하면 오류가 발생합니다.
// 클래스(Google ID 토큰) auth/account-exists-with-different-credential와 함께 발생 합니다.
// AuthCredential원하는 제공자에 대한 로그인 절차를 완료하려면 사용자는 먼저 기존 제공자(예: Facebook)에 로그인한 다음
// 이전 제공자 AuthCredential(Google ID 토큰)에 연결해야 합니다.
  ///
//   Future<String?> diffCredential() async {
//     FirebaseAuth auth = FirebaseAuth.instance;
//
// // Create a credential from a Google Sign-in Request
//     var googleAuthCredential =
//         GoogleAuthProvider.credential(accessToken: 'xxxx');
//
//     try {
//       // Attempt to sign in the user in with Google
//       await auth.signInWithCredential(googleAuthCredential);
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'account-exists-with-different-credential') {
//         // The account already exists with a different credential
//         String? email = e.email;
//         AuthCredential? pendingCredential = e.credential;
//
//         // Fetch a list of what sign-in methods exist for the conflicting user
//         List<String> userSignInMethods =
//             await auth.fetchSignInMethodsForEmail(email);
//
//         // If the user has several sign-in methods,
//         // the first method in the list will be the "recommended" method to use.
//         if (userSignInMethods.first == 'password') {
//           // Prompt the user to enter their password
//           String password = '...';
//
//           // Sign the user in to their account with the password
//           UserCredential userCredential = await auth.signInWithEmailAndPassword(
//             email: email,
//             password: password,
//           );
//
//           // Link the pending credential with the existing account
//           await userCredential.user.linkWithCredential(pendingCredential);
//
//           // Success! Go back to your application flow
//           return goToApplication();
//         }
//
//         // Since other providers are now external, you must now sign the user in with another
//         // auth provider, such as Facebook.
//         if (userSignInMethods.first == 'facebook.com') {
//           // Create a new Facebook credential
//           String accessToken = await triggerFacebookAuthentication();
//           var facebookAuthCredential =
//               FacebookAuthProvider.credential(accessToken);
//
//           // Sign the user in with the credential
//           UserCredential userCredential =
//               await auth.signInWithCredential(facebookAuthCredential);
//
//           // Link the pending credential with the existing account
//           await userCredential.user.linkWithCredential(pendingCredential);
//
//           // Success! Go back to your application flow
//           return goToApplication();
//         }
//
//         // Handle other OAuth providers...
//       }
//     }
//   }
}
