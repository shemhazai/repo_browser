import 'package:get_it/get_it.dart';
import 'package:repo_browser/app/di/di.dart';
import 'package:repo_browser/model/git/git_use_case.dart';
import 'package:repo_browser/model/git/git_use_case_impl.dart';

/// A module that provides use cases for DI.
abstract class UseCasesModule {
  static void register(GetIt locator) {
    locator.registerLazySingleton<GitRepositoryUseCase>(() => GitRepositoryUseCaseImpl(inject()));
  }
}
