import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    // if (kIsWeb) {
    //   return web;
    // }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      // case TargetPlatform.macOS:
      //   return macos;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // static const FirebaseOptions web = FirebaseOptions(
  //   apiKey: 'AIzaSyB7wZb2tO1-Fs6GbDADUSTs2Qs3w08Hovw',
  //   appId: '1:406099696497:web:87e25e51afe982cd3574d0',
  //   messagingSenderId: '406099696497',
  //   projectId: 'flutterfire-e2e-tests',
  //   authDomain: 'flutterfire-e2e-tests.firebaseapp.com',
  //   databaseURL:
  //       'https://flutterfire-e2e-tests-default-rtdb.europe-west1.firebasedatabase.app',
  //   storageBucket: 'flutterfire-e2e-tests.appspot.com',
  //   measurementId: 'G-JN95N1JV2E',
  // );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBhzYW8l0hDbeOrTXA4M6LGOILW2d6W3Gs',
    appId: '1:656621123867:android:f3e06d37d2a7ed1826fbbe',
    messagingSenderId: '656621123867',
    projectId: 'flutterex-b6096',
    databaseURL:
        'https://flutterfire-e2e-tests-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'flutterfire-e2e-tests.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBhzYW8l0hDbeOrTXA4M6LGOILW2d6W3Gs',
    appId: '1:656621123867:android:f3e06d37d2a7ed1826fbbe',
    messagingSenderId: '656621123867',
    projectId: 'flutterex-b6096',
    databaseURL:
        'https://flutterfire-e2e-tests-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'flutterfire-e2e-tests.appspot.com',
    androidClientId:
        '406099696497-tvtvuiqogct1gs1s6lh114jeps7hpjm5.apps.googleusercontent.com',
    iosClientId:
        '406099696497-taeapvle10rf355ljcvq5dt134mkghmp.apps.googleusercontent.com',
    iosBundleId: 'io.flutter.plugins.firebase.tests',
  );

  // static const FirebaseOptions macos = FirebaseOptions(
  //   apiKey: 'AIzaSyDooSUGSf63Ghq02_iIhtnmwMDs4HlWS6c',
  //   appId: '1:406099696497:ios:acd9c8e17b5e620e3574d0',
  //   messagingSenderId: '406099696497',
  //   projectId: 'flutterfire-e2e-tests',
  //   databaseURL:
  //       'https://flutterfire-e2e-tests-default-rtdb.europe-west1.firebasedatabase.app',
  //   storageBucket: 'flutterfire-e2e-tests.appspot.com',
  //   androidClientId:
  //       '406099696497-tvtvuiqogct1gs1s6lh114jeps7hpjm5.apps.googleusercontent.com',
  //   iosClientId:
  //       '406099696497-taeapvle10rf355ljcvq5dt134mkghmp.apps.googleusercontent.com',
  //   iosBundleId: 'io.flutter.plugins.firebase.tests',
  // );
}
