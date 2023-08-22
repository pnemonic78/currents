import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currentsapi_model/db/news_db.dart';
import 'package:currentsapi_model/prefs/user_prefs.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'repo.dart';

class CurrentsRepositoryLocal extends CurrentsRepository {
  final CollectionReference<UserPreferences> _usersRef;
  final CollectionReference<NewsCollection> _latestNewsRef;

  static const _tableUsers = "users";
  static const _tableLatestNews = "latest-news";

  CurrentsRepositoryLocal(FirebaseFirestore db)
      : _usersRef = db.collection(_tableUsers).withConverter<UserPreferences>(
              fromFirestore: (snapshots, _) =>
                  UserPreferences.fromJson(snapshots.data()!),
              toFirestore: (user, _) => user.toJson(),
            ),
        _latestNewsRef =
            db.collection(_tableLatestNews).withConverter<NewsCollection>(
                  fromFirestore: (snapshots, _) =>
                      NewsCollection.fromJson(snapshots.data()!),
                  toFirestore: (article, _) => article.toJson(),
                );

  @override
  Future<UserPreferences> getUserPreferences() async {
    final user = FirebaseAuth.instance.currentUser;
    final String userId = user!.uid;

    final userDoc = _usersRef.doc(userId);
    final userSnapshot = await userDoc.get();
    if (userSnapshot.exists) {
      final userData = userSnapshot.data();
      if (userData != null) return userData;
    }

    UserPreferences userPrefs = UserPreferences();
    await userDoc.set(userPrefs);
    return userPrefs;
  }

  @override
  Future<void> setUserPreferences(UserPreferences userPreferences) async {
    final user = FirebaseAuth.instance.currentUser;
    final String userId = user!.uid;
    final userDoc = _usersRef.doc(userId);
    userDoc.set(userPreferences);
  }

  @override
  Future<NewsCollection> getLatestNews(String languageCode) async {
    final newsDoc = _latestNewsRef.doc(languageCode);
    final newsSnapshot = await newsDoc.get();
    if (newsSnapshot.exists) {
      final newsData = newsSnapshot.data();
      if (newsData != null) return newsData;
    }

    final news = await NewsCollection.parseLatestNews();
    return NewsCollection(news: news)
      ..timestamp = DateTime.now().subtract(const Duration(hours: 1));
  }

  @override
  Future<void> setLatestNews(NewsCollection news, String languageCode) async {
    final newsDoc = _latestNewsRef.doc(languageCode);
    newsDoc.set(news);
  }
}
