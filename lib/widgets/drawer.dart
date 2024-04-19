import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../main.dart';
import '../router/router.dart';

Drawer getDrawer(BuildContext context) {
  final theme = Theme.of(context);
  return Drawer(
    child: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Image.asset(path('images/logo.png')),
            const Text("Подготовка к ЦТ", style: TextStyle(fontSize: 20)),
            const Divider(),
            _getListTitle(context,
                name: "Главная",
                icon: const Icon(Icons.home),
                pageRoute: const HomeRoute(),
                isSelected: true
            ),
            _getListTitle(context,
                name: "Настройки",
                icon: const Icon(Icons.settings),
                pageRoute: const SettingsRoute(),
                isSelected: false
            ),
          ],
        ),
      ),
    ),
  );
}

ListTile _getListTitle(BuildContext context, {
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
      selectedTileColor: theme.colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ));
}
