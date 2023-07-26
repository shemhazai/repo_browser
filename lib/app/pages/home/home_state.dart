import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:repo_browser/model/git/entity/repository.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.loading() = _LoadingState;
  const factory HomeState.empty() = _EmptyState;
  const factory HomeState.noResults() = _NoResultsState;
  const factory HomeState.content({required RepositoriesSearchResult searchResult}) = _ContentState;
  const factory HomeState.error(Object error) = _ErrorState;
}

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.search(String query) = HomeSearchEvent;
}
