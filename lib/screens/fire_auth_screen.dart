import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterex/controllers/fire_auth_controller.dart';
import 'package:flutterex/firebase/firebase_auth_utils.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:flutterex/widget/textformfield_widget.dart';
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
  final FocusNode emailFocusNode = new FocusNode();
  final FocusNode pwdFocusNode = new FocusNode();
  final tedIdController = TextEditingController();
  final tedPwdController = TextEditingController();

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
                              FirebaseAuthUtils.instance.signOut();
                              // controller.signOut();
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
                        TextButton(
                            onPressed: () async {
                              controller.anonymousAuth();
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

                                      if (controller.checkEmail(emailFocusNode,
                                              tedIdController.text) &&
                                          controller.checkPwd(pwdFocusNode,
                                              tedPwdController.text)) {
                                        controller
                                            .createUserWithEmailAndPassword(
                                                tedIdController.text,
                                                tedPwdController.text);
                                      }
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

                                      if (controller.checkEmail(emailFocusNode,
                                              tedIdController.text) &&
                                          controller.checkPwd(pwdFocusNode,
                                              tedPwdController.text)) {
                                        controller.signInWithEmailAndPassword(
                                            tedIdController.text,
                                            tedPwdController.text);
                                      }
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
                            Expanded(
                                // flex: 1,
                                child: TextButton(
                                    onPressed: () async {
                                      FocusScope.of(context).unfocus();

                                      if (controller.checkEmail(emailFocusNode,
                                          tedIdController.text)) {
                                        controller.fetchSignInMethodsForEmail(
                                            tedIdController.text);
                                      }
                                    },
                                    style: TextButton.styleFrom(
                                      minimumSize: Size.fromHeight(60),
                                      backgroundColor:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    child: QcText.headline6(
                                      '중복emil체크',
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
                              controller.signInWithGoogle();
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
                            onPressed: () async {
                              controller.signInWithFacebook();
                            },
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
                            onPressed: () async {
                              controller.signInWithApple();
                            },
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
