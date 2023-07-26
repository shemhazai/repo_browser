import 'package:get_it/get_it.dart';
import 'package:repo_browser/app/di/di.dart';
import 'package:repo_browser/app/pages/home/home_bloc.dart';
import 'package:repo_browser/app/pages/repository/repository_bloc.dart';

/// A module that provides blocs/cubits for DI.
abstract class BlocsModule {
  static void register(GetIt locator) {
    locator.registerFactory(() => HomeBloc(inject()));
    locator.registerFactory(() => RepositoryBloc(inject()));
  }
}
