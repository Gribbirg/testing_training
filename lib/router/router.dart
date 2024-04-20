import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import '../features/home/view/home_page.dart';
import '../features/module_select/view/module_select_page.dart';
import '../features/questions/view/questions_page.dart';
import '../features/settings/view/settings_page.dart';
import '../repositories/questions/models/models.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, path: '/'),
    AutoRoute(page: SettingsRoute.page, path: '/settings'),
    AutoRoute(page: ModuleSelectRoute.page, path: '/modules'),
    AutoRoute(page: QuestionsRoute.page, path: '/modules/questions'),
  ];
}
