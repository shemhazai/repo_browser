import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repo_browser/app/pages/home/home_page.dart';
import 'package:repo_browser/app/pages/home/home_state.dart';
import 'package:repo_browser/common/logger/logger.dart';
import 'package:repo_browser/model/git/git_use_case.dart';

const Logger _logger = Logger('HomeBloc');

/// State management for the [HomePage].
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GitRepositoryUseCase _useCase;

  HomeBloc(this._useCase) : super(const HomeState.empty()) {
    on<HomeSearchEvent>(
      _search,
      transformer: droppable(),
    );
  }

  Future<void> _search(HomeSearchEvent event, Emitter<HomeState> emit) async {
    try {
      if (event.query.isEmpty) {
        emit(const HomeState.empty());
        return;
      }

      emit(const HomeState.loading());

      final searchResult = await _useCase.searchRepositories(event.query);
      if (searchResult.items.isEmpty) {
        emit(const HomeState.noResults());
      } else {
        emit(HomeState.content(searchResult: searchResult));
      }
    } on Exception catch (error, stackTrace) {
      emit(HomeState.error(error));
      _logger.logError(error, stackTrace);
    }
  }
}
