import 'package:repo_browser/model/article/article_use_case.dart';
import 'package:repo_browser/model/article/entity/article.dart';
import 'package:repo_browser/model/article/repository/article_repository.dart';

class ArticleUseCaseImpl implements ArticleUseCase {
  final ArticleRepository _repository;

  ArticleUseCaseImpl(this._repository);

  @override
  Future<SearchResult> searchArticles(String query) {
    return _repository.searchArticles(query);
  }
}
