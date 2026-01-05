import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDmFKYHehsWCvzoZAUSbEwtFVlgBxCMO7U",
            authDomain: "connek-408700.firebaseapp.com",
            projectId: "connek-408700",
            storageBucket: "connek-408700.firebasestorage.app",
            messagingSenderId: "1094194250370",
            appId: "1:1094194250370:web:6df0bcd17b48ca885a2a9b",
            measurementId: "G-16XRYWSBGL"));
  } else {
    await Firebase.initializeApp();
  }
}
