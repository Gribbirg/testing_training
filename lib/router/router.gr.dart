// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    ModuleSelectRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ModuleSelectRouteArgs>(
          orElse: () =>
              ModuleSelectRouteArgs(topicId: pathParams.optString('topic')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ModuleSelectPage(
          key: args.key,
          topicId: args.topicId,
        ),
      );
    },
    QuestionsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<QuestionsRouteArgs>(
          orElse: () => QuestionsRouteArgs(
                topicId: pathParams.optString('topic'),
                moduleId: pathParams.optString('module'),
              ));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: QuestionsPage(
          key: args.key,
          topicId: args.topicId,
          moduleId: args.moduleId,
        ),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsPage(),
      );
    },
  };
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ModuleSelectPage]
class ModuleSelectRoute extends PageRouteInfo<ModuleSelectRouteArgs> {
  ModuleSelectRoute({
    Key? key,
    required String? topicId,
    List<PageRouteInfo>? children,
  }) : super(
          ModuleSelectRoute.name,
          args: ModuleSelectRouteArgs(
            key: key,
            topicId: topicId,
          ),
          rawPathParams: {'topic': topicId},
          initialChildren: children,
        );

  static const String name = 'ModuleSelectRoute';

  static const PageInfo<ModuleSelectRouteArgs> page =
      PageInfo<ModuleSelectRouteArgs>(name);
}

class ModuleSelectRouteArgs {
  const ModuleSelectRouteArgs({
    this.key,
    required this.topicId,
  });

  final Key? key;

  final String? topicId;

  @override
  String toString() {
    return 'ModuleSelectRouteArgs{key: $key, topicId: $topicId}';
  }
}

/// generated route for
/// [QuestionsPage]
class QuestionsRoute extends PageRouteInfo<QuestionsRouteArgs> {
  QuestionsRoute({
    Key? key,
    required String? topicId,
    required String? moduleId,
    List<PageRouteInfo>? children,
  }) : super(
          QuestionsRoute.name,
          args: QuestionsRouteArgs(
            key: key,
            topicId: topicId,
            moduleId: moduleId,
          ),
          rawPathParams: {
            'topic': topicId,
            'module': moduleId,
          },
          initialChildren: children,
        );

  static const String name = 'QuestionsRoute';

  static const PageInfo<QuestionsRouteArgs> page =
      PageInfo<QuestionsRouteArgs>(name);
}

class QuestionsRouteArgs {
  const QuestionsRouteArgs({
    this.key,
    required this.topicId,
    required this.moduleId,
  });

  final Key? key;

  final String? topicId;

  final String? moduleId;

  @override
  String toString() {
    return 'QuestionsRouteArgs{key: $key, topicId: $topicId, moduleId: $moduleId}';
  }
}

/// generated route for
/// [SettingsPage]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
