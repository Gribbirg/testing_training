import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:testing_training/router/router.dart';

import '../main.dart';

class BaseDrawer extends StatefulWidget {
  const BaseDrawer({super.key, required this.scaffoldKey});

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<BaseDrawer> createState() => _BaseDrawerState();
}

class _BaseDrawerState extends State<BaseDrawer> {
  late Image _logo;

  @override
  void initState() {
    _logo = Image.asset(
      path('images/logo.png'),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            _getHeader(),
            getBaseDrawerListTile(
                context: context,
                icon: const Icon(Icons.home),
                title: const Text("Главная"),
                onTap: () {
                  widget.scaffoldKey.currentState!.closeDrawer();
                  AutoRouter.of(context).push(const HomeRoute());
                },
                routeName: HomeRoute.name),
            getBaseDrawerListTile(
                context: context,
                icon: const Icon(Icons.settings),
                title: const Text("Настройки"),
                onTap: () {
                  widget.scaffoldKey.currentState!.closeDrawer();
                  AutoRouter.of(context).push(const SettingsRoute());
                },
                routeName: SettingsRoute.name)
          ],
        ),
      ),
    );
  }

  static Widget getBaseDrawerListTile({
    required BuildContext context,
    required Widget icon,
    required Widget title,
    required void Function() onTap,
    String? routeName,
  }) =>
      ListTile(
        leading: icon,
        title: title,
        onTap: onTap,
        selected: AutoRouter.of(context).current.name == routeName,
        selectedColor: Theme.of(context).colorScheme.primary,
        selectedTileColor: Theme.of(context).colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      );

  Widget _getHeader() => UserAccountsDrawerHeader(
        accountName: Text(
          "Подготовка к ЦТ",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        accountEmail: null,
        currentAccountPicture: _logo,
        currentAccountPictureSize: const Size(100, 100),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
        ),
      );
}
