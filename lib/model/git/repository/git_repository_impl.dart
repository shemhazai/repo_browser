import 'package:repo_browser/model/git/entity/issue.dart';
import 'package:repo_browser/model/git/entity/repository.dart';
import 'package:repo_browser/model/git/repository/api/repository_api.dart';
import 'package:repo_browser/model/git/repository/git_repository.dart';

class GitRepositoryImpl implements GitRepository {
  final RepositoryApi _api;

  GitRepositoryImpl(this._api);

  @override
  Future<RepositoriesSearchResult> searchRepositories(String query) {
    return _api.getRepositories(query);
  }

  @override
  Future<List<Issue>> searchIssues(String user, String repo) {
    return _api.getIssues(user, repo);
  }
}
