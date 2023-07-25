
import 'package:repo_browser/model/git/entity/repository.dart';

/// An abstraction over a concrete data source for repositories.
abstract class GitRepository {
  Future<SearchResult> searchRepositories(String query);
}
