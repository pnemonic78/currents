import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currentsapi_auth/user/user_controller.dart';
import 'package:currentsapi_core/data/repo.dart';
import 'package:currentsapi_core/data/repo_impl.dart';
import 'package:currentsapi_core/data/repo_local.dart';
import 'package:currentsapi_core/data/repo_remote.dart';
import 'package:currentsapi_core/news/net/api.dart';
import 'package:currentsapi_core/news/net/api_impl.dart';
import 'package:currentsapi_core/news/net/rest_client.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

Future<void> injectDependencies() async {
  final db = _provideDatabase();
  final local = _provideRepositoryLocal(db);

  final dio = _provideHttpClient();
  final client = _provideRest(dio);
  final api = _provideApi(client);
  final remote = _provideRepositoryRemote(api);

  final repo = _provideRepository(local, remote);
  Get.put<CurrentsRepository>(repo);

  Get.put<UserController>(UserController(repo));
}

FirebaseFirestore _provideDatabase() {
  return FirebaseFirestore.instance;
}

CurrentsRepository _provideRepositoryLocal(FirebaseFirestore db) {
  return CurrentsRepositoryLocal(db);
}

Dio _provideHttpClient() {
  return Dio();
}

RestClient _provideRest(Dio dio) {
  return RestClient(dio);
}

CurrentsApi _provideApi(RestClient client) {
  return CurrentsApiImpl(client);
}

CurrentsRepository _provideRepositoryRemote(CurrentsApi api) {
  return CurrentsRepositoryRemote(api);
}

CurrentsRepository _provideRepository(
  CurrentsRepository local,
  CurrentsRepository remote,
) {
  return CurrentRepositoryImpl(local, remote);
}
