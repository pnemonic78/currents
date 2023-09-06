import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currentsapi_model/api/search_request.dart';
import 'package:currentsapi_model/db/filters_db.dart';
import 'package:currentsapi_model/db/news_db.dart';
import 'package:currentsapi_model/prefs/user_prefs.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'repo.dart';

class CurrentsRepositoryLocal extends CurrentsRepository {
  final CollectionReference<UserPreferences> _usersRef;
  final CollectionReference<NewsCollection> _latestNewsRef;
  final CollectionReference<FiltersCollection> _filtersRef;
  final CollectionReference<NewsCollection> _searchesRef;

  static const _tableUsers = "users";
  static const _tableLatestNews = "latest-news";
  static const _tableFilters = "filters";
  static const _tableSearches = "searches";
  static const _docFilters = "available";

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
        _filtersRef =
            db.collection(_tableFilters).withConverter<FiltersCollection>(
                  fromFirestore: (snapshots, _) =>
                      FiltersCollection.fromJson(snapshots.data()!),
                  toFirestore: (filters, _) => filters.toJson(),
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
  Stream<NewsCollection> getLatestNews(
    String languageCode, {
    bool refresh = false,
  }) async* {
    final newsDoc = _latestNewsRef.doc(languageCode);
    final newsSnapshot = await newsDoc.get();
    NewsCollection result;
    if (newsSnapshot.exists) {
      final data = newsSnapshot.data();
      result = data ?? NewsCollection.empty();
    } else {
      result = NewsCollection.empty()
        ..timestamp = DateTime.now().subtract(const Duration(days: 999));
    }
    yield result;

    yield* newsDoc
        .snapshots()
        .where((snapshot) => snapshot.exists)
        .map((snapshot) => snapshot.data() ?? result);
  }

  @override
  Future<void> setLatestNews(NewsCollection news, String languageCode) async {
    final newsDoc = _latestNewsRef.doc(languageCode);
    newsDoc.set(news);
  }

  @override
  Future<FiltersCollection> getFilters({bool refresh = false}) async {
    final filtersDoc = _filtersRef.doc(_docFilters);
    final filtersSnapshot = await filtersDoc.get();
    if (filtersSnapshot.exists) {
      final filtersData = filtersSnapshot.data();
      if (filtersData != null) {
        return filtersData;
      }
    }

    FiltersCollection filters = FiltersCollection()
      ..timestamp = DateTime.now().subtract(const Duration(days: 999));
    await filtersDoc.set(filters);
    return filters;
  }

  @override
  Future<void> setFilters(FiltersCollection filters) async {
    final filtersDoc = _filtersRef.doc(_docFilters);
    await filtersDoc.set(filters);
  }

  @override
  Stream<NewsCollection> getSearch(
    SearchRequest request, {
    bool refresh = false,
  }) async* {
    final user = this.user;
    if (user == null) {
      yield NewsCollection.empty();
      return;
    }
    final String userId = user.uid;

    final searchDoc = _searchesRef.doc(userId);
    final searchSnapshot = await searchDoc.get();
    NewsCollection result;
    if (searchSnapshot.exists) {
      final data = searchSnapshot.data();
      result = data ?? NewsCollection.empty();
    } else {
      result = NewsCollection.empty()
        ..timestamp = DateTime.now().subtract(const Duration(days: 999));
    }
    yield result;

    yield* searchDoc
        .snapshots()
        .where((snapshot) => snapshot.exists)
        .map((snapshot) => snapshot.data() ?? result);
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
