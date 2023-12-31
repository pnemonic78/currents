import 'package:currentsapi_app/my/my_app.dart';
import 'package:currentsapi_core/di/get_di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await injectDependencies();
  usePathUrlStrategy();
  runApp(MyApp());
}
