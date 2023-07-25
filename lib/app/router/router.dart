import 'package:auto_route/auto_route.dart';
import 'package:repo_browser/app/router/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(path: '/', page: HomeRoute.page, initial: true),
    AutoRoute(path: '/repository', page: RepositoryRoute.page),
  ];
}
