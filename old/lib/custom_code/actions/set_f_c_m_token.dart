// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

Future setFCMToken() async {
  // PROTECCIÓN 1: Evita reinicializar Firebase si ya está listo
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  FFAppState().fcmToken = "About to check PN permissions";

  // PROTECCIÓN 2: El 'if (!kIsWeb)' evita que busquemos tokens de Apple en el navegador
  if (!kIsWeb) {
    final apnsToken = await messaging.getAPNSToken();
    if (apnsToken != null) {
      FFAppState().apnsStatus = apnsToken;
    } else {
      print("APNs token is not available yet.");
    }
  }

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    FFAppState().fcmToken = "authorizing works";
    try {
      String? fcmToken = await messaging.getToken();
      FFAppState().fcmToken = fcmToken ?? "";
    } catch (e) {
      FFAppState().fcmToken = e.toString();
    }
  }
}
