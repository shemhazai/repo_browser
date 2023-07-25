import 'package:dio/dio.dart';
import 'package:repo_browser/model/article/entity/article.dart';
import 'package:retrofit/retrofit.dart';

part 'article_api.g.dart';

@RestApi()
abstract class ArticleApi {
  factory ArticleApi(Dio dio) = _ArticleApi;

  @GET('/{id}')
  Future<SearchResult> getArticles(@Path('id') String id);
}
