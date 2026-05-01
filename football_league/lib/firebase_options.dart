import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform => web;

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCmqJZs4vH6v75euWyUMeAwFbyM_oWwt-E',
    authDomain: 'app-dm-f1eaf.firebaseapp.com',
    projectId: 'app-dm-f1eaf',
    storageBucket: 'app-dm-f1eaf.firebasestorage.app',
    messagingSenderId: '241425730674',
    appId: '1:241425730674:web:8a3d5af165bf815309c6eb',
    measurementId: 'G-NZNVJNMVQ6',
  );
}
