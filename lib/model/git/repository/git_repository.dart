import 'package:repo_browser/model/git/entity/issue.dart';
import 'package:repo_browser/model/git/entity/repository.dart';

/// An abstraction over a concrete data source for repositories.
abstract class GitRepository {
  Future<RepositoriesSearchResult> searchRepositories(String query);

  Future<List<Issue>> searchIssues(String user, String repo);
}
