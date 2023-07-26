import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:repo_browser/model/git/entity/issue.dart';

part 'repository_state.freezed.dart';

@freezed
class RepositoryState with _$RepositoryState {
  const factory RepositoryState.loading() = _LoadingState;
  const factory RepositoryState.content({required List<Issue> issues}) = _ContentState;
  const factory RepositoryState.noResults() = _NoResultsState;
  const factory RepositoryState.error(Object error) = _ErrorState;
}
