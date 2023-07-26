import 'package:repo_browser/model/git/entity/issue.dart';
import 'package:repo_browser/model/git/entity/repository.dart';

/// A business logic around repositories use case.
abstract class GitRepositoryUseCase {
  Future<RepositoriesSearchResult> searchRepositories(String query);

  Future<List<Issue>> searchIssues(String user, String repo);
}
