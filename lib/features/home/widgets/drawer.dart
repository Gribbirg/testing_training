import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../../router/router.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  late Image logo;

  @override
  void initState() {
    super.initState();
    logo = Image.asset(path('images/logo.png'));
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(logo.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              logo,
              const Text("Подготовка к ЦТ", style: TextStyle(fontSize: 20)),
              const Divider(),
              _getListTitle(context,
                  name: "Главная",
                  icon: const Icon(Icons.home),
                  pageRoute: const HomeRoute(),
                  isSelected: true),
              _getListTitle(context,
                  name: "Настройки",
                  icon: const Icon(Icons.settings),
                  pageRoute: const SettingsRoute(),
                  isSelected: false),
            ],
          ),
        ),
      ),
    );
  }
}

ListTile _getListTitle(
  BuildContext context, {
  required String name,
  required Widget icon,
  required PageRouteInfo pageRoute,
  required bool isSelected,
}) {
  final theme = Theme.of(context);
  return ListTile(
      leading: icon,
      title: Text(name),
      onTap: () {
        AutoRouter.of(context).push(const HomeRoute());
        AutoRouter.of(context).popAndPush(pageRoute);
      },
      selected: isSelected,
      selectedColor: theme.colorScheme.primary,
      // selectedTileColor: theme.colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ));
}
