import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutterex/controllers/fire_auth_controller.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:flutterex/widget/dialog_widget.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:flutterex/widget/textformfield_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

///
/// 이메일, 익명
///
/// 구글, 애플, 페이스북,
/// 카카오
///
/// https://me2.kr/7dpsv
/// https://sudarlife.tistory.com/entry/flutter-firebase-auth-%ED%94%8C%EB%9F%AC%ED%84%B0-%ED%8C%8C%EC%9D%B4%EC%96%B4%EB%B2%A0%EC%9D%B4%EC%8A%A4-%EC%97%B0%EB%8F%99-%EB%A1%9C%EA%B7%B8%EC%9D%B8%EC%9D%84-%EA%B5%AC%EC%97%B0%ED%95%B4%EB%B3%B4%EC%9E%90-part-1?category=1176193
///
/// https://debaeloper.tistory.com/63
///

typedef OAuthSignIn = void Function();

class FireAuthScreen extends StatefulWidget {
  static const routeName = '/fire/auth';

  const FireAuthScreen({Key? key}) : super(key: key);

  @override
  _FireAuthScreenState createState() => _FireAuthScreenState();
}

class _FireAuthScreenState extends State<FireAuthScreen> {
  final FocusNode emailFocusNode = new FocusNode();
  final FocusNode pwdFocusNode = new FocusNode();
  final tedIdController = TextEditingController();
  final tedPwdController = TextEditingController();

  late Map<Buttons, OAuthSignIn> authButtons;

  @override
  void initState() {
    super.initState();

    emailFocusNode.addListener(_focusNodeListener);
    pwdFocusNode.addListener(_focusNodeListener);

    //      FocusScope.of(context).unfocus();
    // KeyboardVisibilityNotification().addNewListener(
    //   onChange: (bool visible) {
    //     print(visible);
    //   },
    // );
    if (kIsWeb) {
      authButtons = {
        // Buttons.Google: _signInWithGoogle,
        // Buttons.GitHub: _signInWithGitHub,
        // Buttons.Twitter: _signInWithTwitter,
      };
    } else {
      authButtons = {
        // if (!Platform.isMacOS) Buttons.Google: _signInWithGoogle,
        // if (!Platform.isMacOS) Buttons.GitHub: _signInWithGitHub,
        // if (!Platform.isMacOS) Buttons.Twitter: _signInWithTwitter,
      };
    }
  }

  @override
  void dispose() {
    emailFocusNode.removeListener(_focusNodeListener);
    pwdFocusNode.removeListener(_focusNodeListener);

    emailFocusNode.dispose();
    pwdFocusNode.dispose();
    super.dispose();
  }

  Future<Null> _focusNodeListener() async {
    if (emailFocusNode.hasFocus) {
      QcLog.e('emailFocusNode got the focus');
    } else {
      QcLog.e('emailFocusNode lost the focus');
    }
    if (pwdFocusNode.hasFocus) {
      QcLog.e('pwdFocusNode got the focus');
    } else {
      QcLog.e('pwdFocusNode lost the focus');
    }
  }

  @override
  Widget build(BuildContext context) {
    FireAuthController controller = Get.find<FireAuthController>();
    // FirebaseAuth.instance.authStateChanges().listen((user) {
    //   if (user != null) {
    //     QcLog.e('FirebaseAuth user : $user');
    //     controller.userCredential.value = 'Sign In : ' + user.toString();
    //
    //     /// Anonymously
    //     /// FirebaseAuth user : User(displayName: null, email: null, emailVerified: false, isAnonymous: true,
    //     /// metadata: UserMetadata(creationTime: 2022-06-16 14:33:17.918, lastSignInTime: 2022-06-16 14:33:17.918), phoneNumber: null, photoURL: null, providerData, [], refreshToken: , tenantId: null, uid: Cf4A40hJQeS3y2u4tjVDOrqR9I23)
    //
    //     /// google
    //     /// FirebaseAuth user : User(displayName: 김웅진, email: wjdev.iosdev.004@gmail.com, emailVerified: true, isAnonymous: false,
    //     /// metadata: UserMetadata(creationTime: 2022-06-16 15:03:51.901, lastSignInTime: 2022-06-16 15:03:51.901), phoneNumber: null, photoURL: https://lh3.googleusercontent.com/a/AATXAJzZmiYnMwnEH_GZulUPsYyIuhe3xNwfibcvOXn4=s96-c, providerData,
    //     /// [UserInfo(displayName: 김웅진, email: wjdev.iosdev.004@gmail.com, phoneNumber: null, photoURL: https://lh3.googleusercontent.com/a/AATXAJzZmiYnMwnEH_GZulUPsYyIuhe3xNwfibcvOXn4=s96-c, providerId: google.com, uid: 109492054029226968010)],
    //     /// refreshToken: , tenantId: null, uid: pToTGwTyQyNYUlCMXHGAdn6PlCA3)
    //   } else {
    //     controller.userCredential.value = 'Sign Out';
    //   }
    // });

    return Obx(() {
      return Scaffold(
          appBar: AppBar(
            title: QcText.headline6(controller.title.value),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          body: SafeArea(
              //  FocusScope.of(context).unfocus();
              // maintainBottomViewPadding: false,
              child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        TextButton(
                            onPressed: () async {
                              controller.signOut();
                              // await FirebaseAuth.instance.signOut();
                            },
                            style: TextButton.styleFrom(
                              minimumSize: Size.fromHeight(60),
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                            child: QcText.headline6(
                              'Firebase sign out',
                              fontColor:
                                  Theme.of(context).colorScheme.onPrimary,
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        QcText.headline6(controller.userCredential.value),
                        const SizedBox(
                          height: 50,
                        ),
                        // Buttons.Google,
                        // SignInButton(
                        //   button,
                        //   onPressed: authButtons[button]!,
                        // ),
                        TextButton(
                            onPressed: () async {
                              controller.anonymousAuth().then((value) {
                                QcLog.e('anonymousAuth : $value');
                                QcDialog.dissmissProgress();

                                /// UserCredential(additionalUserInfo: AdditionalUserInfo(isNewUser: true, profile: {}, providerId: null, username: null), credential: null,
                                /// user: User(displayName: null, email: null, emailVerified: false, isAnonymous: true, metadata: UserMetadata(creationTime: 2022-06-16 15:38:42.049, lastSignInTime: 2022-06-16 15:38:42.049), phoneNumber: null, photoURL: null, providerData, [], refreshToken: , tenantId: null, uid: 0Wy5wOSxZ3R7MjPTCjgtND0zbAy2))
                                ///
                              }).catchError((error) {
                                QcLog.e('error: $error');
                                QcDialog.dissmissProgress();
                              });
                            },
                            style: TextButton.styleFrom(
                              minimumSize: Size.fromHeight(60),
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                            child: QcText.headline6(
                              'Anonymously sign in',
                              fontColor:
                                  Theme.of(context).colorScheme.onPrimary,
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                flex: 1,
                                child: QcTextFormField.bodyText1(
                                  onSaved: (value) {
                                    // controller.saveTextValidate(); 필요
                                    QcLog.e("onSaved : $value");
                                    if (value != null && value.isNotEmpty) {}
                                  },
                                  validator: (value) {
                                    QcLog.e("validator : $value");
                                    if (value != null && value.isEmpty) {
                                      return 'validator Email 를 입력해주세요';
                                    }
                                    return null;
                                  },
                                  hintText: 'Email 입력해주세요',
                                  labelText: 'Email',
                                  keyboardType: TextInputType.emailAddress,
                                  controller: tedIdController,
                                  maxLines: 1,
                                  focusNode: emailFocusNode,
                                  prefixIcon: Icon(Icons.email_outlined),
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  margin: const EdgeInsets.only(top: 22),
                                  child: QcTextFormField.bodyText1(
                                    onSaved: (value) {
                                      // controller.saveTextValidate(); 필요
                                      QcLog.e("onSaved : $value");
                                      if (value != null && value.isNotEmpty) {}
                                    },
                                    // validator: (value) => CheckValidate().validatePassword(_passwordFocus, value),
                                    validator: (value) {
                                      QcLog.e("validator : $value");
                                      if (value != null && value.isEmpty) {
                                        return 'validator PWD를 입력해주세요';
                                      }
                                      return null;
                                    },
                                    hintText: 'PWD를 입력해주세요',
                                    labelText: 'PWD',
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: controller.isObscureText.value,
                                    controller: tedPwdController,
                                    maxLines: 1,
                                    maxLength: 10,
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        QcLog.e('suffixIcon clear ');
                                        controller.isObscureText.value =
                                            !controller.isObscureText.value;
                                      },
                                      icon: Icon(controller.isObscureText.value
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined),
                                    ),
                                    focusNode: pwdFocusNode,
                                    prefixIcon: Icon(Icons.password_outlined),
                                  ),
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                // flex: 1,
                                child: TextButton(
                                    onPressed: () async {
                                      FocusScope.of(context).unfocus();

                                      if (tedIdController.text.isEmpty ||
                                          !tedIdController.text.isEmail) {
                                        Fluttertoast.showToast(
                                            msg: 'Email형식으로 입력해주세요',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1);
                                        // FocusScope.of(context).requestFocus(emailFocusNode)
                                        emailFocusNode.requestFocus();
                                        return;
                                      }
                                      if (tedPwdController.text.isEmpty ||
                                          tedPwdController.text.length < 6) {
                                        Fluttertoast.showToast(
                                            msg: '패스워드는 6자리 이상 입력해주세요',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1);
                                        pwdFocusNode.requestFocus();
                                        return;
                                      }

                                      controller
                                          .signInWithEmail(tedIdController.text,
                                              tedPwdController.text)
                                          .then((value) {
                                        QcLog.e('signInWithEmail : $value');
                                        QcDialog.dissmissProgress();

                                        /// signInWithEmail : UserCredential(additionalUserInfo: AdditionalUserInfo(isNewUser: true, profile: {}, providerId: null, username: null), credential: null,
                                        /// user: User(displayName: null, email: hfhfhhg@huu.mji, emailVerified: false, isAnonymous: false,
                                        /// metadata: UserMetadata(creationTime: 2022-06-17 16:28:22.556, lastSignInTime: 2022-06-17 16:28:22.556), phoneNumber: null, photoURL: null, providerData,
                                        /// [UserInfo(displayName: null, email: hfhfhhg@huu.mji, phoneNumber: null, photoURL: null, providerId: password, uid: hfhfhhg@huu.mji)], refreshToken: , tenantId: null, uid: N3P9YEXu8mUqDMOcWy2jAdNS1eu1))
                                      }).catchError((error) {
                                        QcLog.e('error: $error');

                                        /// error: [firebase_auth/email-already-in-use] The email address is already in use by another account.
                                        QcDialog.dissmissProgress();
                                        Fluttertoast.showToast(
                                            msg: '$error',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1);
                                      });
                                    },
                                    style: TextButton.styleFrom(
                                      minimumSize: Size.fromHeight(60),
                                      backgroundColor:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    child: QcText.headline6(
                                      'email sign in',
                                      fontColor: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ))),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                // flex: 1,
                                child: TextButton(
                                    onPressed: () async {
                                      FocusScope.of(context).unfocus();

                                      if (tedIdController.text.isEmpty ||
                                          !tedIdController.text.isEmail) {
                                        Fluttertoast.showToast(
                                            msg: 'Email형식으로 입력해주세요',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1);
                                        // FocusScope.of(context).requestFocus(emailFocusNode)
                                        emailFocusNode.requestFocus();
                                        return;
                                      }
                                      if (tedPwdController.text.isEmpty ||
                                          tedPwdController.text.length < 6) {
                                        Fluttertoast.showToast(
                                            msg: '패스워드는 6자리 이상 입력해주세요',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1);
                                        pwdFocusNode.requestFocus();
                                        return;
                                      }

                                      controller
                                          .signInWithEmailAndPassword(
                                              tedIdController.text,
                                              tedPwdController.text)
                                          .then((value) {
                                        QcLog.e(
                                            'signInWithEmailAndPassword : $value');
                                        QcDialog.dissmissProgress();

                                        /// signInWithEmailAndPassword : UserCredential(additionalUserInfo: AdditionalUserInfo(isNewUser: false, profile: {}, providerId: null, username: null), credential: null,
                                        /// user: User(displayName: null, email: hfhfhhg@huu.mji, emailVerified: false, isAnonymous: false,
                                        /// metadata: UserMetadata(creationTime: 2022-06-17 16:28:22.556, lastSignInTime: 2022-06-17 16:33:18.320), phoneNumber: null, photoURL: null, providerData,
                                        /// [UserInfo(displayName: null, email: hfhfhhg@huu.mji, phoneNumber: null, photoURL: null, providerId: password, uid: hfhfhhg@huu.mji)], refreshToken: , tenantId: null, uid: N3P9YEXu8mUqDMOcWy2jAdNS1eu1))
                                      }).catchError((error) {
                                        QcLog.e('error: $error');
                                        QcDialog.dissmissProgress();
                                        Fluttertoast.showToast(
                                            msg: '$error',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1);
                                      });
                                    },
                                    style: TextButton.styleFrom(
                                      minimumSize: Size.fromHeight(60),
                                      backgroundColor:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    child: QcText.headline6(
                                      'email Log in',
                                      fontColor: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ))),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                            onPressed: () async {
                              controller.signInWithGoogle().then((value) {
                                QcLog.e('signInWithGoogle : $value');
                                QcDialog.dissmissProgress();

                                /// signInWithGoogle : UserCredential(additionalUserInfo: AdditionalUserInfo(isNewUser: true, profile: {given_name: 웅진, locale: ko, family_name: 김,
                                /// picture: https://lh3.googleusercontent.com/a/AATXAJzZmiYnMwnEH_GZulUPsYyIuhe3xNwfibcvOXn4=s96-c, aud: 656621123867-fmpg2hup4fj6ko27pctkru5bp7hv4idg.apps.googleusercontent.com, azp: 656621123867-l5k7l2udh06907oocnha0bkirafm8h71.apps.googleusercontent.com, exp: 1655363051, iat: 1655359451, iss: https://accounts.google.com, sub: 109492054029226968010, name: 김웅진, email: wjdev.iosdev.004@gmail.com, email_verified: true}, providerId: google.com, username: null), credential: AuthCredential(providerId: google.com, signInMethod: google.com, token: null), user: User(displayName: 김웅진, email: wjdev.iosdev.004@gmail.com, emailVerified: true, isAnonymous: false, metadata: UserMetadata(creationTime: 2022-06-16 15:04:12.849, lastSignInTime: 2022-06-16 15:04:12.849),
                                /// phoneNumber: null, photoURL: https://lh3.googleusercontent.com/a/AATXAJzZmiYnMwnEH_GZ
                              }).catchError((error) {
                                QcLog.e('error: $error');
                                QcDialog.dissmissProgress();
                              });
                            },
                            style: TextButton.styleFrom(
                              minimumSize: Size.fromHeight(60),
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                            child: QcText.headline6(
                              'google sign in',
                              fontColor:
                                  Theme.of(context).colorScheme.onPrimary,
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                            onPressed: () async {},
                            style: TextButton.styleFrom(
                              minimumSize: Size.fromHeight(60),
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                            child: QcText.headline6(
                              'facebook sign in',
                              fontColor:
                                  Theme.of(context).colorScheme.onPrimary,
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                            onPressed: () async {},
                            style: TextButton.styleFrom(
                              minimumSize: Size.fromHeight(60),
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                            child: QcText.headline6(
                              'apple sign in',
                              fontColor:
                                  Theme.of(context).colorScheme.onPrimary,
                            )),
                        const SizedBox(
                          height: 20,
                        ),

                        SignInButtonBuilder(
                          text: 'Get going with Email',
                          icon: Icons.email,
                          onPressed: () {
                            // _showButtonPressDialog(context, 'Email');
                          },
                          backgroundColor: Colors.blueGrey[700]!,
                          width: 220.0,
                        ),
                        Divider(),
                        SignInButton(
                          Buttons.Google,
                          onPressed: () {
                            // _showButtonPressDialog(context, 'Google');
                          },
                        ),
                        Divider(),
                        SignInButton(
                          Buttons.GoogleDark,
                          onPressed: () {
                            // _showButtonPressDialog(context, 'Google (dark)');
                          },
                        ),
                        Divider(),
                        SignInButton(
                          Buttons.FacebookNew,
                          onPressed: () {
                            // _showButtonPressDialog(context, 'FacebookNew');
                          },
                        ),
                        Divider(),
                        SignInButton(
                          Buttons.Apple,
                          onPressed: () {
                            // _showButtonPressDialog(context, 'Apple');
                          },
                        ),
                        Divider(),
                        SignInButton(
                          Buttons.GitHub,
                          text: "Sign up with GitHub",
                          onPressed: () {
                            // _showButtonPressDialog(context, 'Github');
                          },
                        ),
                        Divider(),
                        SignInButton(
                          Buttons.Microsoft,
                          text: "Sign up with Microsoft ",
                          onPressed: () {
                            // _showButtonPressDialog(context, 'Microsoft ');
                          },
                        ),
                        Divider(),
                        SignInButton(
                          Buttons.Twitter,
                          text: "Use Twitter",
                          onPressed: () {
                            // _showButtonPressDialog(context, 'Twitter');
                          },
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SignInButton(
                              Buttons.LinkedIn,
                              mini: true,
                              onPressed: () {
                                // _showButtonPressDialog(context, 'LinkedIn (mini)');
                              },
                            ),
                            SignInButton(
                              Buttons.Tumblr,
                              mini: true,
                              onPressed: () {
                                // _showButtonPressDialog(context, 'Tumblr (mini)');
                              },
                            ),
                            SignInButton(
                              Buttons.Facebook,
                              mini: true,
                              onPressed: () {
                                // _showButtonPressDialog(context, 'Facebook (mini)');
                              },
                            ),
                            SignInButtonBuilder(
                              icon: Icons.email,
                              text: "Ignored for mini button",
                              mini: true,
                              onPressed: () {
                                // _showButtonPressDialog(context, 'Email (mini)');
                              },
                              backgroundColor: Colors.cyan,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))));
    });
  }
}
