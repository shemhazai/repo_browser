import 'package:repo_browser/model/git/entity/repository.dart';
import 'package:repo_browser/model/git/repository/api/repository_api.dart';
import 'package:repo_browser/model/git/repository/git_repository.dart';

class GitRepositoryImpl implements GitRepository {
  final RepositoryApi _api;

  GitRepositoryImpl(this._api);

  @override
  Future<SearchResult> searchRepositories(String query) {
    return _api.getRepositories(query);
  }
}
