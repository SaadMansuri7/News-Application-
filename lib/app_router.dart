// ignore: implementation_imports
import 'package:auto_route/annotations.dart';
import 'package:auto_route/src/route/auto_route_config.dart';
import 'package:newsapp/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomoViewRoute.page),
        AutoRoute(page: LoginViewRoute.page, initial: true),
        AutoRoute(page: SignupViewRoute.page),
        AutoRoute(page: DetailsViewRoute.page),
        AutoRoute(page: ProfileViewRoute.page),
        AutoRoute(page: SearchResultRoute.page)
      ];
}
