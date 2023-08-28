import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currentsapi_core/data/repo.dart';
import 'package:currentsapi_core/data/repo_impl.dart';
import 'package:currentsapi_core/data/repo_local.dart';
import 'package:currentsapi_core/data/repo_remote.dart';
import 'package:currentsapi_core/news/net/api.dart';
import 'package:currentsapi_core/news/net/api_impl.dart';
import 'package:currentsapi_core/news/net/rest_client.dart';
import 'package:currentsapi_model/db/news_db.dart';
import 'package:currentsapi_model/prefs/user_prefs.dart';
import 'package:dio/dio.dart';

// FIXME: this should be in dependency injection.
class CurrentsRepositorySimple extends CurrentsRepository {
  late FirebaseFirestore _db;
  late Dio _dio;
  late RestClient _client;
  late CurrentsApi _api;
  late CurrentsRepositoryLocal _local;
  late CurrentsRepositoryRemote _remote;
  late CurrentsRepository _repo;

  CurrentsRepositorySimple() {
    _db = FirebaseFirestore.instance;
    _dio = Dio();
    _client = RestClient(_dio);
    _api = CurrentsApiImpl(_client);
    _local = CurrentsRepositoryLocal(_db);
    _remote = CurrentsRepositoryRemote(_api);
    _repo = CurrentRepositoryImpl(_local, _remote);
  }

  @override
  Stream<NewsCollection> getLatestNews(
    String languageCode, {
    bool refresh = false,
  }) {
    return _repo.getLatestNews(languageCode, refresh: refresh);
  }

  @override
  Future<UserPreferences> getUserPreferences() {
    return _repo.getUserPreferences();
  }

  @override
  Future<void> setLatestNews(NewsCollection news, String languageCode) {
    return _repo.setLatestNews(news, languageCode);
  }

  @override
  Future<void> setUserPreferences(UserPreferences? userPreferences) {
    return _repo.setUserPreferences(userPreferences);
  }
}
