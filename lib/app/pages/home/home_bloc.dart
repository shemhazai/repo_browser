import 'package:repo_browser/app/common/bloc/base_cubit.dart';
import 'package:repo_browser/app/pages/home/home_page.dart';
import 'package:repo_browser/app/pages/home/home_state.dart';
import 'package:repo_browser/common/logger/logger.dart';
import 'package:repo_browser/model/git/entity/repository.dart';
import 'package:repo_browser/model/git/git_use_case.dart';

const Logger _logger = Logger('HomeBloc');

/// State management for the [HomePage].
class HomeBloc extends BaseCubit<HomeState> {
  final GitRepositoryUseCase _useCase;

  HomeBloc(this._useCase) : super(const HomeState.empty());

  Future<void> search(String text) async {
    try {
      if (text.isEmpty) {
        emit(const HomeState.empty());
        return;
      }

      emit(const HomeState.loading());

      final data = await _useCase.searchRepositories(text);
      final repositories = _mapRepositories(data);
      if (repositories.isEmpty) {
        emit(const HomeState.noResults());
      } else {
        emit(HomeState.content(searchResult: data, headlines: repositories));
      }
    } on Exception catch (error, stackTrace) {
      emit(HomeState.error(error));
      _logger.logError(error, stackTrace);
    }
  }

  List<HomeRepositoryHeadline> _mapRepositories(SearchResult result) {
    return result.items.map((e) {
      return HomeRepositoryHeadline(
        id: e.id,
        title: e.title,
        repository: e,
      );
    }).toList();
  }
}
