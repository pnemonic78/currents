import 'package:currentsapi_app/news/latest_news.dart';
import 'package:currentsapi_app/news/news_article.dart';
import 'package:currentsapi_core/auth/firebase.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import 'my_home_page.dart';
import 'my_route.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currents API',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        MyAppRoute.Home: (context) =>
            const MyHomePage(title: 'Currents API Home Page'),
        MyAppRoute.SignIn: (context) => SignInScreen(
              providers: FirebaseHelper.providers,
              actions: [
                AuthStateChangeAction<SignedIn>((context, state) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, MyAppRoute.Home, (route) => false);
                }),
              ],
            ),
        MyAppRoute.LatestNews: (context) =>
            const LatestNewsScreen(title: 'Latest News'),
        MyAppRoute.NewsArticle: (context) =>
            const NewsArticleScreen(),
        MyAppRoute.Profile: (context) => ProfileScreen(
              providers: FirebaseHelper.providers,
              actions: [
                SignedOutAction((context) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, MyAppRoute.Home, (route) => false);
                }),
              ],
            ),
      },
    );
  }
}
