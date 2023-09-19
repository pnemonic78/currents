import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currentsapi_model/api/search_request.dart';
import 'package:currentsapi_model/db/config_doc.dart';
import 'package:currentsapi_model/db/news_db.dart';
import 'package:currentsapi_model/net/result.dart';
import 'package:currentsapi_model/prefs/user_prefs.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'repo.dart';

class CurrentsRepositoryLocal extends CurrentsRepository {
  final CollectionReference<UserPreferences> _usersRef;
  final CollectionReference<NewsCollection> _latestNewsRef;
  final CollectionReference<ConfigurationDocument> _filtersRef;
  final CollectionReference<NewsCollection> _searchesRef;

  static const _tableUsers = "users";
  static const _tableLatestNews = "latest-news";
  static const _tableConfiguration = "configuration";
  static const _tableSearches = "searches";
  static const _docConfiguration = "config";

  static const _old = Duration(days: 999);

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
                ),
        _filtersRef = db
            .collection(_tableConfiguration)
            .withConverter<ConfigurationDocument>(
              fromFirestore: (snapshots, _) =>
                  ConfigurationDocument.fromJson(snapshots.data()!),
              toFirestore: (config, _) => config.toJson(),
            ),
        _searchesRef =
            db.collection(_tableSearches).withConverter<NewsCollection>(
                  fromFirestore: (snapshots, _) =>
                      NewsCollection.fromJson(snapshots.data()!),
                  toFirestore: (article, _) => article.toJson(),
                );

  User? get user => FirebaseAuth.instance.currentUser;

  @override
  Future<UserPreferences> getUserPreferences() async {
    final user = this.user;
    if (user == null) return UserPreferences();
    final String userId = user.uid;

    final userDoc = _usersRef.doc(userId);
    final userSnapshot = await userDoc.get();
    if (userSnapshot.exists) {
      final userData = userSnapshot.data();
      if (userData != null) {
        userData.displayName = user.displayName;
        userData.photoURL = user.photoURL;
        return userData;
      }
    }

    UserPreferences userPrefs = UserPreferences()
      ..displayName = user.displayName
      ..photoURL = user.photoURL;
    await userDoc.set(userPrefs);
    return userPrefs;
  }

  @override
  Future<void> setUserPreferences(UserPreferences? userPreferences) async {
    final user = this.user;
    if (user == null) return;
    final String userId = user.uid;
    final userDoc = _usersRef.doc(userId);
    if (userPreferences != null) {
      userDoc.set(userPreferences);
    } else {
      userDoc.delete();
    }
  }

  @override
  Stream<TikalResult<NewsCollection>> getLatestNews(
    String languageCode, {
    bool refresh = false,
  }) async* {
    yield TikalResultLoading();

    final user = this.user;
    if (user == null) {
      yield TikalResultError(Exception("No user"));
      return;
    }

    final newsDoc = _latestNewsRef.doc(languageCode);
    final newsSnapshot = await newsDoc.get();
    final NewsCollection result;
    if (newsSnapshot.exists) {
      final data = newsSnapshot.data();
      result = data ?? NewsCollection.empty();
    } else {
      result = NewsCollection.empty()
        ..timestamp = DateTime.now().subtract(_old);
    }
    yield TikalResultSuccess(result);

    yield* newsDoc
        .snapshots()
        .where((snapshot) => snapshot.exists)
        .map((snapshot) => snapshot.data() ?? result)
        .map((r) => TikalResultSuccess(r));
  }

  @override
  Future<void> setLatestNews(NewsCollection news, String languageCode) async {
    final user = this.user;
    if (user == null) return;
    final newsDoc = _latestNewsRef.doc(languageCode);
    newsDoc.set(news);
  }

  @override
  Future<ConfigurationDocument> getConfiguration({bool refresh = false}) async {
    final user = this.user;
    if (user == null) return ConfigurationDocument();

    final filtersDoc = _filtersRef.doc(_docConfiguration);
    final filtersSnapshot = await filtersDoc.get();
    if (filtersSnapshot.exists) {
      final filtersData = filtersSnapshot.data();
      if (filtersData != null) {
        return filtersData;
      }
    }

    ConfigurationDocument config = ConfigurationDocument()
      ..timestamp = DateTime.now().subtract(_old);
    await filtersDoc.set(config);
    return config;
  }

  @override
  Future<void> setConfiguration(ConfigurationDocument config) async {
    final user = this.user;
    if (user == null) return;
    final filtersDoc = _filtersRef.doc(_docConfiguration);
    await filtersDoc.set(config);
  }

  @override
  Stream<TikalResult<NewsCollection>> getSearch(
    SearchRequest request, {
    bool refresh = false,
  }) async* {
    yield TikalResultLoading();

    final user = this.user;
    if (user == null) {
      yield TikalResultError(Exception("No user"));
      return;
    }
    final String userId = user.uid;

    final searchDoc = _searchesRef.doc(userId);
    final searchSnapshot = await searchDoc.get();
    final NewsCollection result;
    if (searchSnapshot.exists) {
      final data = searchSnapshot.data();
      result = data ?? NewsCollection.empty();
    } else {
      result = NewsCollection.empty()
        ..timestamp = DateTime.now().subtract(_old);
    }
    yield TikalResultSuccess(result);

    yield* searchDoc
        .snapshots()
        .where((snapshot) => snapshot.exists)
        .map((snapshot) => snapshot.data() ?? result)
        .map((r) => TikalResultSuccess(r));
  }

  @override
  Future<void> setSearch(NewsCollection? result) async {
    final user = this.user;
    if (user == null) return;
    final String userId = user.uid;
    final searchDoc = _searchesRef.doc(userId);
    if (result != null) {
      searchDoc.set(result);
    } else {
      searchDoc.delete();
    }
  }
}
