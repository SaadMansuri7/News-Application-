import 'package:newsapp/model/article.dart';

class ArticleResponse {
  final List<Articles> articles;
  final String? nextPage;

  ArticleResponse({
    required this.articles,
    this.nextPage,
  });
}
