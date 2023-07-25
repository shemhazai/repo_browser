import 'package:dio/dio.dart';
import 'package:repo_browser/model/git/entity/repository.dart';
import 'package:retrofit/retrofit.dart';

part 'repository_api.g.dart';

@RestApi()
abstract class RepositoryApi {
  factory RepositoryApi(Dio dio) = _RepositoryApi;

  @GET('/search/repositories')
  Future<SearchResult> getRepositories(@Query('q') String query);
}
