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
        return macos;
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
    apiKey: 'AIzaSyCgUcY3ZTw5vWa-z4WUpRNQgTHW5aXdltc',
    appId: '1:937555690164:web:56643468e5074095488de1',
    messagingSenderId: '937555690164',
    projectId: 'testing-training-e498b',
    authDomain: 'testing-training-e498b.firebaseapp.com',
    storageBucket: 'testing-training-e498b.appspot.com',
    measurementId: 'G-2YQ5JHXS6W',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA84mOUn8sQa7_0fldng3JlZsgvYB83fXM',
    appId: '1:937555690164:android:a9311b378d3e8d03488de1',
    messagingSenderId: '937555690164',
    projectId: 'testing-training-e498b',
    storageBucket: 'testing-training-e498b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAcPI-QgC7iIws8sxoD3NFYLEZjzn2GS0M',
    appId: '1:937555690164:ios:909afdad25d7bad2488de1',
    messagingSenderId: '937555690164',
    projectId: 'testing-training-e498b',
    storageBucket: 'testing-training-e498b.appspot.com',
    iosBundleId: 'ru.gribtestingtraining.testingTraining',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAcPI-QgC7iIws8sxoD3NFYLEZjzn2GS0M',
    appId: '1:937555690164:ios:909afdad25d7bad2488de1',
    messagingSenderId: '937555690164',
    projectId: 'testing-training-e498b',
    storageBucket: 'testing-training-e498b.appspot.com',
    iosBundleId: 'ru.gribtestingtraining.testingTraining',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCgUcY3ZTw5vWa-z4WUpRNQgTHW5aXdltc',
    appId: '1:937555690164:web:a38f3f69b0cb03f3488de1',
    messagingSenderId: '937555690164',
    projectId: 'testing-training-e498b',
    authDomain: 'testing-training-e498b.firebaseapp.com',
    storageBucket: 'testing-training-e498b.appspot.com',
    measurementId: 'G-H85LFZ5GTG',
  );
}