import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:repo_browser/app/di/di.dart';
import 'package:repo_browser/common/data/app_environment.dart';
import 'package:repo_browser/model/article/repository/api/article_api.dart';
import 'package:repo_browser/model/article/repository/article_repository.dart';
import 'package:repo_browser/model/article/repository/article_repository_impl.dart';

/// A module that provides apis/repositories/data sources for DI.
abstract class RepositoriesModule {
  static void register(GetIt locator) {
    locator.registerLazySingleton(() => _buildDio(inject()));
    locator.registerLazySingleton(() => ArticleApi(inject()));
    locator.registerLazySingleton<ArticleRepository>(() => ArticleRepositoryImpl(inject()));
  }
}

Dio _buildDio(AppEnvironment environment) {
  return Dio()
    ..options = BaseOptions(baseUrl: environment.baseUrl)
    ..interceptors.addAll([
      if (kDebugMode) PrettyDioLogger(requestHeader: true, requestBody: true),
    ]);
}
