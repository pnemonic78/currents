import 'package:currentsapi_core/auth/firebase.dart';
import 'package:currentsapi_model/api/news.dart';
import 'package:currentsapi_news/news/latest_news_screen.dart';
import 'package:currentsapi_news/news/news_arguments.dart';
import 'package:currentsapi_news/news/news_article_screen.dart';
import 'package:currentsapi_settings/settings/settings_arguments.dart';
import 'package:currentsapi_settings/settings/settings_screen.dart';
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
                  _goHome(context);
                }),
              ],
            ),
        MyAppRoute.LatestNews: (context) => LatestNewsScreen(
              onTap: (article) => _showNews(context, article),
            ),
        MyAppRoute.NewsArticle: (context) => const NewsArticleScreen(),
        MyAppRoute.Profile: (context) => ProfileScreen(
              providers: FirebaseHelper.providers,
              actions: [
                SignedOutAction((context) {
                  _goHome(context);
                }),
              ],
            ),
        MyAppRoute.Settings: (context) => const SettingsScreen(),
      },
    );
  }

  void _goHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, MyAppRoute.Home, (route) => false);
  }

  void _showNews(BuildContext context, Article article) {
    Navigator.pushNamed(
      context,
      MyAppRoute.NewsArticle,
      arguments: NewsArguments(article),
    );
  }
}
