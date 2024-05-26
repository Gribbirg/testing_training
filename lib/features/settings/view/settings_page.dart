import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testing_training/features/settings/widgets/settings_drawer.dart';
import 'package:testing_training/features/settings/widgets/settings_list_tile_widget.dart';
import 'package:testing_training/router/router.dart';

import '../../../widgets/adaptive_scaffold.dart';

@RoutePage()
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      scaffoldKey: _key,
      drawer: SettingsDrawer(scaffoldKey: _key),
      appBarTitle: "Настройки",
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                children: [
                  SettingsListTileWidget(
                    title: 'Внешний вид',
                    onTap: () {
                      AutoRouter.of(context).push(const ColorsSelectRoute());
                    },
                    icon: const Icon(Icons.color_lens),
                  ),
                  SettingsListTileWidget(
                    title: 'О приложении',
                    onTap: () {
                      AutoRouter.of(context).push(const AboutAppRoute());
                    },
                    icon: const Icon(Icons.info),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
