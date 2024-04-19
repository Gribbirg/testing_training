import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';

import '../features/home/view/home_page.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, path: '/'),
  ];
}
