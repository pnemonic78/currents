import 'package:currentsapi_core/data/repo.dart';
import 'package:currentsapi_model/prefs/user_prefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  late FirebaseAuth provider;
  final isSignedIn = false.obs;
  final CurrentsRepository _repository;
  final user = UserPreferences().obs;

  UserController(this._repository);

  @override
  void onInit() async {
    provider = FirebaseAuth.instance;
    user.value = await _repository.getUserPreferences();
    super.onInit();
  }

  @override
  void onReady() async {
    isSignedIn.value = provider.currentUser != null;
    provider.authStateChanges().listen((user) {
      isSignedIn.value = user != null;
    });
    super.onReady();
  }

  void signOut() async {
    await provider.signOut();
  }

  void listenSignedIn(WorkerCallback<bool> callback) {
    ever(isSignedIn, callback);
  }

  void setUserPreferences(UserPreferences? userPreferences) async {
    user.value = userPreferences ?? UserPreferences();
    _repository.setUserPreferences(userPreferences);
  }
}
