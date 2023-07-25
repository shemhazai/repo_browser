import 'package:repo_browser/model/article/entity/article.dart';

/// A business logic around articles use case.
abstract class ArticleUseCase {
  Future<SearchResult> searchArticles(String query);
}
