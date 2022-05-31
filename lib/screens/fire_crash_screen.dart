import 'dart:async';
import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterex/controllers/fire_crash_controller.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:get/get.dart';

class FireCrashScreen extends StatefulWidget {
  static const routeName = '/fire/crash';

  const FireCrashScreen({Key? key}) : super(key: key);

  @override
  _FireCrashScreenState createState() => _FireCrashScreenState();
}

class _FireCrashScreenState extends State<FireCrashScreen> {
  var _kTestingCrashlytics = true;
  var _kShouldTestAsyncErrorOnInit = false;

  late Future<void> _initializeFlutterFireFuture;

  Future<void> _testAsyncErrorOnInit() async {
    Future<void>.delayed(const Duration(seconds: 2), () {
      final List<int> list = <int>[];
      print(list[100]);
    });
  }

  Future<void> _initializeFlutterFire() async {
    if (_kTestingCrashlytics) {
      // Force enable crashlytics collection enabled if we're testing it.
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    } else {
      // Else only enable it in non-debug builds.
      // You could additionally extend this to allow users to opt-in.
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(!kDebugMode);
    }

    if (_kShouldTestAsyncErrorOnInit) {
      await _testAsyncErrorOnInit();
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeFlutterFireFuture = _initializeFlutterFire();
  }

  @override
  Widget build(BuildContext context) {
    QcLog.e("PushScreen =============");
    FireCrashController controller = Get.find<FireCrashController>();

    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: QcText.headline6(controller.title.value),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: SafeArea(
          // maintainBottomViewPadding 키보드가 올라온 경우 밀어낼지 덮을지 결정
          // maintainBottomViewPadding: false,
          child: Container(
              color: Theme.of(context).colorScheme.background,
              width: Get.width,
              height: Get.height,
              child: Column(
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        QcLog.e("Exception");
                        throw Exception();
                      },
                      child: QcText.headline6(
                        'Exception 발생',
                        // fontColor: Theme.of(context).colorScheme.onPrimary,
                      )),
                  ElevatedButton(
                    onPressed: () {
                      FirebaseCrashlytics.instance
                          .setCustomKey('example', 'Custom key is flutterfire');
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'Custom Key "example: flutterfire" has been set \n'
                            'Key will appear in Firebase Console once an error has been reported.'),
                        duration: Duration(seconds: 5),
                      ));
                    },
                    child: QcText.headline6('Key'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      FirebaseCrashlytics.instance.log('This is a log example');
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'The message "This is a log example" has been logged \n'
                            'Message will appear in Firebase Console once an error has been reported.'),
                        duration: Duration(seconds: 5),
                      ));
                    },
                    child: QcText.headline6('Log'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'Thrown error has been caught and sent to Crashlytics.'),
                        duration: Duration(seconds: 5),
                      ));

                      // Example of thrown error, it will be caught and sent to
                      // Crashlytics.
                      throw StateError('Uncaught error thrown by app');
                    },
                    child: QcText.headline6('Throw Error'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'Uncaught Exception that is handled by second parameter of runZonedGuarded.'),
                        duration: Duration(seconds: 5),
                      ));

                      // Example of an exception that does not get caught
                      // by `FlutterError.onError` but is caught by
                      // `runZonedGuarded`.
                      runZonedGuarded(() {
                        Future<void>.delayed(const Duration(seconds: 2), () {
                          final List<int> list = <int>[];
                          print(list[100]);
                        });
                      }, FirebaseCrashlytics.instance.recordError);
                    },
                    child: QcText.headline6('Async out of bounds'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Recorded Error'),
                          duration: Duration(seconds: 5),
                        ));
                        throw Error();
                      } catch (e, s) {
                        // "reason" will append the word "thrown" in the
                        // Crashlytics console.
                        await FirebaseCrashlytics.instance.recordError(e, s,
                            reason: 'as an example of fatal error',
                            fatal: true);
                      }
                    },
                    child: QcText.headline6('Record Fatal Error'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Recorded Error'),
                          duration: Duration(seconds: 5),
                        ));
                        throw Error();
                      } catch (e, s) {
                        // "reason" will append the word "thrown" in the
                        // Crashlytics console.
                        await FirebaseCrashlytics.instance.recordError(e, s,
                            reason: 'as an example of non-fatal error');
                      }
                    },
                    child: QcText.headline6('Record Non-Fatal Error'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('App will crash is 5 seconds \n'
                            'Please reopen to send data to Crashlytics'),
                        duration: Duration(seconds: 5),
                      ));

                      // Delay crash for 5 seconds
                      sleep(const Duration(seconds: 5));

                      // Use FirebaseCrashlytics to throw an error. Use this for
                      // confirmation that errors are being correctly reported.
                      FirebaseCrashlytics.instance.crash();
                    },
                    child: QcText.headline6('Crash'),
                  ),
                ],
              )),
        ),
      );
    });
  }
}
