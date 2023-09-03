import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  late FirebaseAuth provider;
  final isSignedIn = false.obs;

  @override
  void onInit() async {
    provider = FirebaseAuth.instance;
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
}
