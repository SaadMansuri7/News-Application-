import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:newsapp/model/article.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/model/articleResponse.dart';

class NewsServices {
  static final String? apiKey = dotenv.env['API_KEY'];
  static final String baseUrl =
      'https://newsdata.io/api/1/latest?apikey=$apiKey&country=in,us,gb,ar,au&language=en&category=education,technology,world,science,business&timezone=Asia/Kolkata';

  Future<ArticleResponse?> getArticles({String? page}) async {
    try {
      final Uri url = Uri.parse(
        '$baseUrl${page != null ? '&page=$page' : ''}',
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        // print('Response: $jsonResponse');
        final List<Articles> articles = List<Articles>.from(
            jsonResponse['results'].map((a) => Articles.fromMap(a)));

        // print(
        // 'next page : $jsonResponse["nextPage"] ///////////////////////////////////////////////////////////////////////////////////////');
        return ArticleResponse(
            articles: articles, nextPage: jsonResponse['nextPage']);
      } else {
        print('Failed to load articles: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<ArticleResponse?> getArticleByKeyword(
      {String? nextPage, required String value}) async {
    try {
      final baseUrlWithKeywords =
          'https://newsdata.io/api/1/latest?apikey=$apiKey&country=in,us,gb,ar,au&language=en&category=education,technology,world,science,business&timezone=Asia/Kolkata&qInTitle=$value${nextPage != null ? '&page=$nextPage' : ''}';
      final Uri url = Uri.parse(baseUrlWithKeywords);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        // print('Response: $jsonResponse');
        final List<dynamic> results = jsonResponse['results'] ?? [];
        final List<Articles> articles = results
            .map((articleJson) => Articles.fromMap(articleJson))
            .toList();

        return ArticleResponse(
          articles: articles,
          nextPage: jsonResponse['nextPage'],
        );
      } else {
        print('Failed to load articles: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
