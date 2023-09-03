import 'package:currentsapi_core/data/repo.dart';
import 'package:currentsapi_model/db/news_db.dart';
import 'package:get/get.dart';

class LatestNewsController extends GetxController {
  final _repo = Get.find<CurrentsRepository>();

  Stream<NewsCollection> getLatestNewsForUser({
    bool refresh = false,
  }) async* {
    final user = await _repo.getUserPreferences();
    yield* _repo.getLatestNewsForUser(user, refresh: refresh);
  }
}
