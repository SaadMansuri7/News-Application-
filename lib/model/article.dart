// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';

class Articles {
  final String article_id;
  final String title;
  final String link;
  final String? creator;
  final String? description;
  final String? content;
  final DateTime? pubDate;
  final String source_id;
  final String source_name;
  final String? image_url;
  final String language;
  final List<String>? country;
  final List<String>? category;
  final String? nextPage;
  final List<String>? keywords;

  Articles({
    required this.article_id,
    required this.title,
    required this.link,
    this.creator,
    this.description,
    this.content,
    this.pubDate,
    required this.source_id,
    required this.source_name,
    this.image_url,
    required this.language,
    this.country,
    this.category,
    this.nextPage,
    this.keywords,
  });

  Articles copyWith({
    String? article_id,
    String? title,
    String? link,
    String? creator,
    String? description,
    String? content,
    DateTime? pubDate,
    String? source_id,
    String? source_name,
    String? image_url,
    String? language,
    List<String>? country,
    List<String>? category,
    String? nextPage,
    List<String>? keywords,
  }) {
    return Articles(
      article_id: article_id ?? this.article_id,
      title: title ?? this.title,
      link: link ?? this.link,
      creator: creator ?? this.creator,
      description: description ?? this.description,
      content: content ?? this.content,
      pubDate: pubDate ?? this.pubDate,
      source_id: source_id ?? this.source_id,
      source_name: source_name ?? this.source_name,
      image_url: image_url ?? this.image_url,
      language: language ?? this.language,
      country: country ?? this.country,
      category: category ?? this.category,
      nextPage: nextPage ?? this.nextPage,
      keywords: keywords ?? this.keywords,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'article_id': article_id,
      'title': title,
      'link': link,
      'creator': creator,
      'description': description,
      'content': content,
      'pubDate': pubDate?.millisecondsSinceEpoch,
      'source_id': source_id,
      'source_name': source_name,
      'image_url': image_url,
      'language': language,
      'country': country,
      'category': category,
      'nextPage': nextPage,
      'keywords': keywords,
    };
  }

  factory Articles.fromMap(Map<String, dynamic> map) {
    final creatorValue = map['creator'];
    final keywordsValue = map['keywords'];

    return Articles(
      article_id: map['article_id'] as String,
      title: map['title'] as String,
      link: map['link'] as String,
      creator: creatorValue is List ? creatorValue.join(', ') : creatorValue,
      description: map['description'] as String?,
      content: map['content'] as String?,
      pubDate: map['pubDate'] is String
          ? DateTime.tryParse(map['pubDate'])
          : DateTime.now(),
      source_id: map['source_id'] as String,
      source_name: map['source_name'] as String,
      image_url: map['image_url'] as String?,
      language: map['language'] as String,
      country:
          map['country'] != null ? List<String>.from(map['country']) : null,
      category:
          map['category'] != null ? List<String>.from(map['category']) : null,
      nextPage: map['nextPage'] as String?,
      keywords: keywordsValue is String
          ? [keywordsValue]
          : keywordsValue is List
              ? List<String>.from(keywordsValue)
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Articles.fromJson(String source) =>
      Articles.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Articles(article_id: $article_id, title: $title, link: $link, creator: $creator, description: $description, content: $content, pubDate: $pubDate, source_id: $source_id, source_name: $source_name, image_url: $image_url, language: $language, country: $country, category: $category, nextPage: $nextPage, keywords: $keywords)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Articles &&
        other.article_id == article_id &&
        other.title == title &&
        other.link == link &&
        other.creator == creator &&
        other.description == description &&
        other.content == content &&
        other.pubDate == pubDate &&
        other.source_id == source_id &&
        other.source_name == source_name &&
        other.image_url == image_url &&
        other.language == language &&
        listEquals(other.country, country) &&
        listEquals(other.category, category) &&
        other.nextPage == nextPage &&
        listEquals(other.keywords, keywords);
  }

  @override
  int get hashCode {
    return article_id.hashCode ^
        title.hashCode ^
        link.hashCode ^
        creator.hashCode ^
        description.hashCode ^
        content.hashCode ^
        pubDate.hashCode ^
        source_id.hashCode ^
        source_name.hashCode ^
        image_url.hashCode ^
        language.hashCode ^
        country.hashCode ^
        category.hashCode ^
        nextPage.hashCode ^
        keywords.hashCode;
  }
}
