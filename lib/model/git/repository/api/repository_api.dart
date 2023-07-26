import 'package:dio/dio.dart';
import 'package:repo_browser/model/git/entity/issue.dart';
import 'package:repo_browser/model/git/entity/repository.dart';
import 'package:retrofit/retrofit.dart';

part 'repository_api.g.dart';

@RestApi()
abstract class RepositoryApi {
  factory RepositoryApi(Dio dio) = _RepositoryApi;

  @GET('/search/repositories')
  Future<RepositoriesSearchResult> getRepositories(
    @Query('q') String query,
  );

  @GET('/repos/{user}/{repo}/issues')
  Future<List<Issue>> getIssues(
    @Path('user') String user,
    @Path('repo') String repo,
  );
}
