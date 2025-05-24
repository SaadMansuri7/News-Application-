import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newsapp/baseViewModel.dart';
import 'package:newsapp/model/article.dart';
import 'package:newsapp/services/newsServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeViewModel extends BaseViewModel {
  final NewsServices newsServices = NewsServices();
  List<Articles?> _articles = [];
  List<Articles?> get articles => _articles;
  List<Articles> _bookmarkedArticles = [];
  List<Articles> get bookmarkedArticles => _bookmarkedArticles;
  List<Articles?> _filteredArticles = [];
  List<Articles?> get filterdarticles => _filteredArticles;
  List<String> _allKeywords = [];
  List<String> get allKeywords => _allKeywords;
  List<String> get suggestions => _suggestions;
  List<String> _suggestions = [];
  String? nextPage;
  bool _isLoad = false;
  bool get isLoad => _isLoad;
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  // HomeViewModel({required bool initialDarkMode}) {
  //   fetchArticles();
  //   getAllBookmarkedArticles();
  //   loadThemePreference();
  // }

  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  HomeViewModel({required bool initialDarkMode})
      : _isDarkMode = initialDarkMode {
    fetchArticles();
    getAllBookmarkedArticles();
    // loadThemePreference();
  }

  void toggleTheme(bool isDark) async {
    _isDarkMode = isDark;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDark);
  }

  Future<void> fetchArticles({bool loadMore = false}) async {
    try {
      if (loadMore && (nextPage == null || isLoad)) {
        return;
      }

      _isLoad = loadMore;
      notifyListeners();

      final response = await newsServices.getArticles(page: nextPage);

      if (response != null) {
        nextPage = response.nextPage;

        if (loadMore) {
          final existingIds = _articles.map((a) => a!.article_id).toSet();

          final uniqueNewArticles = response.articles
              .where(
                (newArticle) => !existingIds.contains(newArticle.article_id),
              )
              .toList();

          _articles.addAll(uniqueNewArticles);
        } else {
          _articles = response.articles;
          // _filteredArticles = _articles;
          getKeywords();
        }

        print('Articles: $_articles ///////////////////// from model');
        notifyListeners();
      }
    } catch (e) {
      print(e);
    } finally {
      _isLoad = false;
      notifyListeners();
    }
  }

  Future<void> refreshArticles(
      {bool loadMore = false, required BuildContext context}) async {
    try {
      if (loadMore && (nextPage == null || isLoad)) {
        return;
      }

      _isLoad = loadMore;
      notifyListeners();

      final response = await newsServices.getArticles(page: nextPage);

      if (response != null) {
        nextPage = response.nextPage;

        _articles = response.articles;
        // _filteredArticles = _articles;
        getKeywords();

        // print('Articles: $_articles ///////////////////// from model');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: const Text(
              "Articles refreshed successfully.",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            duration: const Duration(seconds: 2),
          ),
        );
        notifyListeners();
      }
    } catch (e) {
      print(e);
    } finally {
      _isLoad = false;
      notifyListeners();
    }
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

  Future<void> toggleBookmark(Articles article, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final key = 'article_${email}_${article.article_id}';

    if (bookmarkedArticles.any((a) => a.article_id == article.article_id)) {
      await prefs.remove(key);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: const Text(
            "Articles is unsaved!",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      await prefs.setString(key, jsonEncode(article.toJson()));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: const Text(
            "Article saved successfully",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          duration: const Duration(seconds: 2),
        ),
      );
    }

    await getAllBookmarkedArticles();
    notifyListeners();
  }

  Future<void> getKeywords() async {
    try {
      final Set<String> keywords = {};
      for (var article in _articles) {
        if (article?.keywords != null) {
          keywords.addAll(article!.keywords!);
        }
        _allKeywords = keywords.toList();
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void giveSuggestions(String query) async {
    try {
      if (query.isEmpty) {
        _suggestions = [];
      } else {
        _suggestions = _allKeywords
            .where((kw) => kw.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

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
    }
  }

  void loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }
}

  // Future<void> saveArticle(Articles article) async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final email = prefs.getString('email');
  //     final key = 'article_${email}_${article.article_id}';

  //     if (prefs.containsKey(key)) {
  //       print('Article is alraedy saved!');
  //       return;
  //     }

  //     await prefs.setString(key, jsonEncode(article.toJson()));
  //     // print("Saved article under key: $key and $article");
  //   } catch (e) {
  //     print(e);
  //   }
  // }