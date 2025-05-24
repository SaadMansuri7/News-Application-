import 'dart:convert';

import 'package:newsapp/baseViewModel.dart';
import 'package:newsapp/model/article.dart';
import 'package:newsapp/services/newsServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchViewModel extends BaseViewModel {
  final newsServices = NewsServices();
  bool _isLoad = false;
  bool get isLoad => _isLoad;
  List<Articles?> _filteredArticles = [];
  List<Articles?> get filterdarticles => _filteredArticles;
  List<Articles> _bookmarkedArticles = [];
  List<Articles> get bookmarkedArticles => _bookmarkedArticles;

  Future<void> getArticlesByKeywords(String value) async {
    try {
      _isLoad = true;
      notifyListeners();
      final result = await newsServices.getArticleByKeyword(value: value);
      if (result != null) {
        _filteredArticles = result.articles;
      } else {
        _filteredArticles = [];
      }
      _isLoad = false;
      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      _isLoad = false;
      notifyListeners();
    }
  }

  Future<void> toggleBookmark(Articles article) async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final key = 'article_${email}_${article.article_id}';

    if (bookmarkedArticles.any((a) => a.article_id == article.article_id)) {
      await prefs.remove(key);
    } else {
      await prefs.setString(key, jsonEncode(article.toJson()));
    }

    await getAllBookmarkedArticles();
    notifyListeners();
  }

  Future<void> getAllBookmarkedArticles() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString('email');
      final allKeys = prefs.getKeys();

      final articleKeys =
          allKeys.where((key) => key.startsWith('article_${email}_')).toList();

      final articles = articleKeys
          .map((key) {
            final jsonString = prefs.getString(key);
            if (jsonString != null) {
              return Articles.fromJson(jsonDecode(jsonString));
            }
            return null;
          })
          .whereType<Articles>()
          .toList();
      _bookmarkedArticles = articles;
      print('bookmarked articles list : $_bookmarkedArticles');
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
