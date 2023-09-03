import 'package:currentsapi_app/favorites/favorites_screen.dart';
import 'package:currentsapi_app/news/latest_news_screen.dart';
import 'package:currentsapi_app/news/news_article_screen.dart';
import 'package:currentsapi_app/settings/settings_screen.dart';
import 'package:currentsapi_core/auth/firebase.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'my_home_page.dart';
import 'my_route.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Currents API',
      theme: ThemeData.light(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.light,
          onPrimary: Colors.white,
        ),
      ),
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrangeAccent,
          brightness: Brightness.dark,
          onPrimary: Colors.black,
        ),
      ),
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      initialRoute: MyAppRoute.Home,
      routes: {
        MyAppRoute.Favorites: (context) => const FavoritesScreen(),
        MyAppRoute.Home: (context) =>
            const MyHomePage(title: 'Currents API Home Page'),
        MyAppRoute.LatestNews: (context) => const LatestNewsScreen(),
        MyAppRoute.NewsArticle: (context) => const NewsArticleScreen(),
        MyAppRoute.Profile: (context) => ProfileScreen(
              providers: FirebaseHelper.providers,
            ),
        MyAppRoute.Settings: (context) => const SettingsScreen(),
        MyAppRoute.SignIn: (context) => SignInScreen(
              providers: FirebaseHelper.providers,
              actions: [
                AuthStateChangeAction<SignedIn>((context, state) {
                  _gotoHome(context);
                }),
              ],
            ),
      },
    );
  }

  void _gotoHome(BuildContext context) {
    Get.offAllNamed(MyAppRoute.Home);
  }
}
