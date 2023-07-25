import 'package:repo_browser/model/git/entity/repository.dart';
import 'package:repo_browser/model/git/git_use_case.dart';
import 'package:repo_browser/model/git/repository/git_repository.dart';

class GitRepositoryUseCaseImpl implements GitRepositoryUseCase {
  final GitRepository _repository;

  GitRepositoryUseCaseImpl(this._repository);

  @override
  Future<SearchResult> searchRepositories(String query) {
    return _repository.searchRepositories(query);
  }
}
