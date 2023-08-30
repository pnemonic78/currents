import 'package:currentsapi_app/my/my_app.dart';
import 'package:currentsapi_core/auth/firebase.dart';
import 'package:currentsapi_core/di/get_di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await FirebaseHelper.init();
  await injectDependencies();
  runApp(const MyApp());
}
