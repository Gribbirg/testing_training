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
      final args = routeData.argsAs<ModuleSelectRouteArgs>(
          orElse: () => const ModuleSelectRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ModuleSelectPage(
          key: args.key,
          topic: args.topic,
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
    Topic? topic,
    List<PageRouteInfo>? children,
  }) : super(
          ModuleSelectRoute.name,
          args: ModuleSelectRouteArgs(
            key: key,
            topic: topic,
          ),
          initialChildren: children,
        );

  static const String name = 'ModuleSelectRoute';

  static const PageInfo<ModuleSelectRouteArgs> page =
      PageInfo<ModuleSelectRouteArgs>(name);
}

class ModuleSelectRouteArgs {
  const ModuleSelectRouteArgs({
    this.key,
    this.topic,
  });

  final Key? key;

  final Topic? topic;

  @override
  String toString() {
    return 'ModuleSelectRouteArgs{key: $key, topic: $topic}';
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
