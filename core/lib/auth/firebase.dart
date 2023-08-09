import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/foundation.dart';

import 'firebase_options.dart';
import 'keys.dart';

class FirebaseHelper {
  static Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseUIAuth.configureProviders(providers);
    if (kDebugMode) {
      print('±!@ FirebaseAuth user=${FirebaseAuth.instance.currentUser}');
    }
  }

  static final List<GoogleProvider> providers = [
    GoogleProvider(clientId: Keys.GOOGLE_CLIENT_ID),
  ];
}
