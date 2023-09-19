import 'package:currentsapi_core/ui/app_i18n.dart';
import 'package:currentsapi_core/ui/app_themes.dart';
import 'package:currentsapi_home/auth/profile_screen.dart';
import 'package:currentsapi_home/auth/signin_screen.dart';
import 'package:currentsapi_home/favorites/favorites_screen.dart';
import 'package:currentsapi_home/news/latest_news_screen.dart';
import 'package:currentsapi_home/news/news_article_screen.dart';
import 'package:currentsapi_home/search/search_results_screen.dart';
import 'package:currentsapi_home/search/search_screen.dart';
import 'package:currentsapi_home/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'my_home_controller.dart';
import 'my_home_page.dart';
import 'my_middle.dart';
import 'my_route.dart';

class MyApp extends StatelessWidget {
  final _middleware = MyMiddleware();

  MyApp({super.key}) {
    Get.put<MyHomeController>(MyHomeController());
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Currents API',
      theme: AppTheme.themeLight,
      darkTheme: AppTheme.themeDark,
      localizationsDelegates: AppLocalizations.delegates,
      initialRoute: MyAppRoute.Home,
      getPages: [
        GetPage(
          name: MyAppRoute.Favorites,
          page: () => const FavoritesScreen(),
          middlewares: [_middleware],
        ),
        GetPage(
          name: MyAppRoute.Home,
          page: () => const MyHomePage(title: 'Currents API Home Page'),
          middlewares: [_middleware],
        ),
        GetPage(
          name: MyAppRoute.LatestNews,
          page: () => const LatestNewsScreen(),
          middlewares: [_middleware],
        ),
        GetPage(
          name: MyAppRoute.NewsArticle,
          page: () => const NewsArticleScreen(),
          middlewares: [_middleware],
        ),
        GetPage(
          name: MyAppRoute.Profile,
          page: () => const UserProfileScreen(),
          middlewares: [_middleware],
        ),
        GetPage(
          name: MyAppRoute.Search,
          page: () => const SearchScreen(),
          middlewares: [_middleware],
        ),
        GetPage(
          name: MyAppRoute.SearchResults,
          page: () => const SearchResultsScreen(),
          middlewares: [_middleware],
        ),
        GetPage(
          name: MyAppRoute.Settings,
          page: () => const SettingsScreen(),
          middlewares: [_middleware],
        ),
        GetPage(
          name: MyAppRoute.SignIn,
          page: () => const UserSignInScreen(),
          middlewares: [_middleware],
        ),
      ],
    );
  }
}
