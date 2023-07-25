import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:repo_browser/model/git/entity/repository.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.loading() = _Loading;
  const factory HomeState.empty() = _Empty;
  const factory HomeState.noResults() = _NoResults;
  const factory HomeState.content({
    required SearchResult searchResult,
    required List<HomeRepositoryHeadline> headlines,
  }) = _Content;
  const factory HomeState.error(Object error) = _Error;
}

@freezed
class HomeRepositoryHeadline with _$HomeRepositoryHeadline {
  const factory HomeRepositoryHeadline({
    required String id,
    required String title,
    required Repository repository,
  }) = _HomeRepositoryHeadline;
}
