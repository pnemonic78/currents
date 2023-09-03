import 'package:currentsapi_model/api/news.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsArticleController extends GetxController {
  Article? article;

  void onArticleSourcePressed() {
    final article = this.article;
    if (article != null) {
      _gotoArticle(article);
    }
  }

  void _gotoArticle(Article article) async {
    final urlString = article.url;
    final url = Uri.parse(urlString);
    launchUrl(url);
  }

  void filterCategory(String category) async {
    //TODO implement me!
  }
}
