import 'package:repo_browser/app/common/bloc/base_cubit.dart';
import 'package:repo_browser/app/pages/repository/repository_page.dart';
import 'package:repo_browser/app/pages/repository/repository_state.dart';
import 'package:repo_browser/common/logger/logger.dart';
import 'package:repo_browser/model/git/entity/repository.dart';
import 'package:repo_browser/model/git/git_use_case.dart';

const Logger _logger = Logger('RepositoryBloc');

/// State management for the [RepositoryPage].
class RepositoryBloc extends BaseCubit<RepositoryState> {
  final GitRepositoryUseCase _useCase;

  RepositoryBloc(this._useCase) : super(const RepositoryState.loading());

  Future<void> loadData(Repository repository) async {
    try {
      emit(const RepositoryState.loading());
      final issues = await _useCase.searchIssues(repository.owner.login, repository.name);
      if (issues.isEmpty) {
        emit(const RepositoryState.noResults());
      } else {
        emit(RepositoryState.content(issues: issues));
      }
    } on Exception catch (error, stackTrace) {
      emit(RepositoryState.error(error));
      _logger.logError(error, stackTrace);
    }
  }
}
