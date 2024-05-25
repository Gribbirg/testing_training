import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import '../features/home/view/home_page.dart';
import '../features/module_select/view/module_select_page.dart';
import '../features/news/view/news_page.dart';
import '../features/questions/view/questions_page.dart';
import '../features/settings/view/about_app_page.dart';
import '../features/settings/view/colors_page.dart';
import '../features/settings/view/settings_page.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, path: '/'),
        AutoRoute(page: SettingsRoute.page, path: '/settings'),
        AutoRoute(page: ColorsSelectRoute.page, path: '/settings/colors'),
        AutoRoute(page: AboutAppRoute.page, path: '/settings/about'),
        AutoRoute(page: NewsRoute.page, path: '/news'),
        AutoRoute(page: ModuleSelectRoute.page, path: '/:topic'),
        AutoRoute(page: QuestionsRoute.page, path: '/:topic/:module'),
      ];
}
