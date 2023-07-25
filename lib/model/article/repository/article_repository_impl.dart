import 'package:dio/dio.dart';
import 'package:repo_browser/common/logger/logger.dart';
import 'package:repo_browser/model/article/entity/article.dart';
import 'package:repo_browser/model/article/exception/article_exceptions.dart';
import 'package:repo_browser/model/article/repository/api/article_api.dart';
import 'package:repo_browser/model/article/repository/article_repository.dart';

const Logger _logger = Logger('ArticleRepository');

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleApi _api;

  ArticleRepositoryImpl(this._api);

  @override
  Future<SearchResult> searchArticles(String query) async {
    try {
      return await _api.getArticles(query);
    } on DioException catch (error, stackTrace) {
      _logger.logError(error, stackTrace);

      if (error.message == 'invalid_query') {
        throw const SearchArticleInvalidQueryException();
      } else {
        throw const SearchArticleNoResultsException();
      }
    }
  }
}
