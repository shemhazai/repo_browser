import 'package:repo_browser/model/git/entity/repository.dart';

/// A business logic around repositories use case.
abstract class GitRepositoryUseCase {
  Future<SearchResult> searchRepositories(String query);
}
