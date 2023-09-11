import 'package:currentsapi_core/data/repo.dart';
import 'package:currentsapi_model/db/news_db.dart';
import 'package:currentsapi_model/net/result.dart';
import 'package:get/get.dart';

class LatestNewsController extends GetxController {
  final _repo = Get.find<CurrentsRepository>();

  Stream<TikalResult<NewsCollection>> getLatestNewsForUser({
    bool refresh = false,
  }) async* {
    final user = await _repo.getUserPreferences();
    yield* _repo.getLatestNewsForUser(user, refresh: refresh);
  }

  Stream<TikalResult<NewsCollection>> getLatestNews({
    String? language,
    bool refresh = false,
  }) {
    return (language != null)
        ? _repo.getLatestNews(language, refresh: refresh)
        : getLatestNewsForUser(refresh: refresh);
  }
}
