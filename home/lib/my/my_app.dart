import 'package:currentsapi_core/auth/firebase.dart';
import 'package:currentsapi_core/ui/app_i18n.dart';
import 'package:currentsapi_core/ui/app_themes.dart';
import 'package:currentsapi_home/favorites/favorites_screen.dart';
import 'package:currentsapi_home/news/latest_news_screen.dart';
import 'package:currentsapi_home/news/news_article_screen.dart';
import 'package:currentsapi_home/search/search_results_screen.dart';
import 'package:currentsapi_home/search/search_screen.dart';
import 'package:currentsapi_home/settings/settings_screen.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
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
      theme: AppTheme.themeLight,
      darkTheme: AppTheme.themeDark,
      localizationsDelegates: AppLocalizations.delegates,
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
        MyAppRoute.Search: (context) => const SearchScreen(),
        MyAppRoute.SearchResults: (context) => const SearchResultsScreen(),
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
