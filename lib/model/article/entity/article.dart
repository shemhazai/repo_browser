import 'package:freezed_annotation/freezed_annotation.dart';

part 'article.freezed.dart';
part 'article.g.dart';

@freezed
class SearchResult with _$SearchResult {
  const SearchResult._();

  const factory SearchResult({
    required List<ArticleHeadline> pages,
    required List<Article> items,
  }) = _SearchResult;

  factory SearchResult.fromJson(Map<String, dynamic> json) => _$SearchResultFromJson(json);

  Article getArticle(String id) {
    return items.firstWhere((e) => e.id == id);
  }
}

@freezed
class ArticleHeadline with _$ArticleHeadline {
  const factory ArticleHeadline({
    required String id,
    required String title,
    required String itemId,
  }) = _ArticleHeadline;

  factory ArticleHeadline.fromJson(Map<String, dynamic> json) => _$ArticleHeadlineFromJson(json);
}

@freezed
class Article with _$Article {
  const factory Article({
    required String id,
    required String title,
    required String imageUrl,
    required String body,
  }) = _Article;

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);
}
