import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testing_training/router/router.dart';
import 'package:testing_training/widgets/drawer.dart';

class SettingsDrawer extends StatefulWidget {
  const SettingsDrawer({super.key, required this.scaffoldKey});

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<SettingsDrawer> createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends State<SettingsDrawer> {
  @override
  Widget build(BuildContext context) {
    return BaseDrawer(
      scaffoldKey: widget.scaffoldKey,
      body: [
        getBaseDrawerListTile(
          context: context,
          icon: const Icon(Icons.color_lens),
          title: const Text('Внешний вид'),
          onTap: () {
            widget.scaffoldKey.currentState!.closeDrawer();
            AutoRouter.of(context).push(const ColorsSelectRoute());
          },
          routeName: ColorsSelectRoute.name,
        ),
        getBaseDrawerListTile(
          context: context,
          icon: const Icon(Icons.info),
          title: const Text('О приложении'),
          onTap: () {
            widget.scaffoldKey.currentState!.closeDrawer();
            AutoRouter.of(context).push(const AboutAppRoute());
          },
          routeName: AboutAppRoute.name,
        )
      ],
    );
  }
}
