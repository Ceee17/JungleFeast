// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBmzMIPuKKVLjqCp951BGgU55djVc-dEdc',
    appId: '1:54392670266:web:e470408ee499e8c41acd03',
    messagingSenderId: '54392670266',
    projectId: 'junglefeast-17ddc',
    authDomain: 'junglefeast-17ddc.firebaseapp.com',
    storageBucket: 'junglefeast-17ddc.appspot.com',
    measurementId: 'G-5Y64CVJZP2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDNVBma7642y_qfZlQYMRxhufMEGeTxRpY',
    appId: '1:54392670266:android:d7e160b3e3f243c31acd03',
    messagingSenderId: '54392670266',
    projectId: 'junglefeast-17ddc',
    storageBucket: 'junglefeast-17ddc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDsim5aO77HvZSmcW_HWPoZwHw_AXg57Z0',
    appId: '1:54392670266:ios:4ef314a517f281d81acd03',
    messagingSenderId: '54392670266',
    projectId: 'junglefeast-17ddc',
    storageBucket: 'junglefeast-17ddc.appspot.com',
    androidClientId:
        '54392670266-j9o0tsoh25sb7b5quqfrc56dca22v1c6.apps.googleusercontent.com',
    iosClientId:
        '54392670266-shcn8m6ndb3lr67rssmv1a930po3rc79.apps.googleusercontent.com',
    iosBundleId: 'com.junglefeast',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBmzMIPuKKVLjqCp951BGgU55djVc-dEdc',
    appId: '1:54392670266:web:fea6d76da3cf7f5b1acd03',
    messagingSenderId: '54392670266',
    projectId: 'junglefeast-17ddc',
    authDomain: 'junglefeast-17ddc.firebaseapp.com',
    storageBucket: 'junglefeast-17ddc.appspot.com',
    measurementId: 'G-53HKBSTG9G',
  );
}
