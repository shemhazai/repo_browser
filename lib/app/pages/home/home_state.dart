import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:repo_browser/model/article/entity/article.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.loading() = _Loading;
  const factory HomeState.empty() = _Empty;
  const factory HomeState.noResults() = _NoResults;
  const factory HomeState.content({
    required SearchResult searchResult,
    required List<HomeArticleHeadline> headlines,
  }) = _Content;
  const factory HomeState.error(Object error) = _Error;
}

@freezed
class HomeArticleHeadline with _$HomeArticleHeadline {
  const factory HomeArticleHeadline({
    required String id,
    required String title,
    required Article article,
  }) = _HomeArticlePage;
}
