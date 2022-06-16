import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterex/controllers/fire_auth_controller.dart';
import 'package:flutterex/controllers/fire_storage_controller.dart';
import 'package:flutterex/network/dio_client.dart';
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
class FireAuthScreen extends StatefulWidget {
  static const routeName = '/fire/auth';

  const FireAuthScreen({Key? key}) : super(key: key);

  @override
  _FireAuthScreenState createState() => _FireAuthScreenState();
}

class _FireAuthScreenState extends State<FireAuthScreen> {
  FocusNode myFocusNode = new FocusNode();
  final tedIdController = TextEditingController();
  final tedPwdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    myFocusNode.addListener(_focusNodeListener);

    //      FocusScope.of(context).unfocus();
    // KeyboardVisibilityNotification().addNewListener(
    //   onChange: (bool visible) {
    //     print(visible);
    //   },
    // );
  }

  @override
  void dispose() {
    myFocusNode.removeListener(_focusNodeListener);

    super.dispose();
  }

  Future<Null> _focusNodeListener() async {
    if (myFocusNode.hasFocus) {
      QcLog.e('TextField got the focus');
    } else {
      QcLog.e('TextField lost the focus');
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
                        QcText.headline6(controller.userCredential.value),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
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
                          height: 50,
                        ),
                        TextButton(
                            onPressed: () async {
                              controller.anonymously().then((value) {
                                QcLog.e('anonymously : $value');
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
                                      return 'validator ID를 입력해주세요';
                                    }
                                    return null;
                                  },
                                  hintText: 'ID를 입력해주세요',
                                  labelText: 'ID',
                                  keyboardType: TextInputType.url,
                                  controller: tedIdController,
                                  maxLines: 1,
                                  focusNode: myFocusNode,
                                  prefixIcon: Icon(Icons.web_outlined),
                                )),
                            const SizedBox(
                              width: 10,
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
                                      return 'validator PWD를 입력해주세요';
                                    }
                                    return null;
                                  },
                                  hintText: 'PWD를 입력해주세요',
                                  labelText: 'PWD',
                                  keyboardType: TextInputType.url,
                                  controller: tedPwdController,
                                  maxLines: 1,
                                  // focusNode: myFocusNode,
                                  prefixIcon: Icon(Icons.web_outlined),
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                // flex: 1,
                                child: TextButton(
                                    onPressed: () async {
                                      FocusScope.of(context).unfocus();

                                      if (tedIdController.text.isEmpty) {
                                        Fluttertoast.showToast(
                                            msg: 'ID를 입력해주세요',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1);
                                        return;
                                      }
                                      if (tedPwdController.text.isEmpty) {
                                        Fluttertoast.showToast(
                                            msg: 'PWD를 입력해주세요',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1);
                                        return;
                                      }

                                      /// ignInWithGoogle : UserCredential(additionalUserInfo: AdditionalUserInfo(isNewUser: true, profile: {given_name: 웅진, locale: ko, family_name: 김,
                                      /// picture: https://lh3.googleusercontent.com/a/AATXAJzZmiYnMwnEH_GZulUPsYyIuhe3xNwfibcvOXn4=s96-c, aud: 656621123867-fmpg2hup4fj6ko27pctkru5bp7hv4idg.apps.googleusercontent.com, azp: 656621123867-l5k7l2udh06907oocnha0bkirafm8h71.apps.googleusercontent.com, exp: 1655363051, iat: 1655359451, iss: https://accounts.google.com, sub: 109492054029226968010, name: 김웅진, email: wjdev.iosdev.004@gmail.com, email_verified: true}, providerId: google.com, username: null), credential: AuthCredential(providerId: google.com, signInMethod: google.com, token: null), user: User(displayName: 김웅진, email: wjdev.iosdev.004@gmail.com, emailVerified: true, isAnonymous: false, metadata: UserMetadata(creationTime: 2022-06-16 15:04:12.849, lastSignInTime: 2022-06-16 15:04:12.849),
                                      /// phoneNumber: null, photoURL: https://lh3.googleusercontent.com/a/AATXAJzZmiYnMwnEH_GZ
                                      controller
                                          .signInWithEmail(tedIdController.text,
                                              tedPwdController.text)
                                          .then((value) {
                                        QcLog.e('signInWithEmail : $value');
                                        QcDialog.dissmissProgress();
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
                                      'email sign in',
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

                                /// ignInWithGoogle : UserCredential(additionalUserInfo: AdditionalUserInfo(isNewUser: true, profile: {given_name: 웅진, locale: ko, family_name: 김,
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
                      ],
                    ),
                  ))));
    });
  }
}
