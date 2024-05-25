import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:testing_training/widgets/app_bar.dart';
import 'package:testing_training/widgets/drawer.dart';

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
    return Scaffold(
      key: _key,
      drawer: BaseDrawer(
        scaffoldKey: _key,
      ),
      appBar: getAppBar(context, text: "Настройки", actions: [
        const Icon(Icons.settings),
        const SizedBox(
          width: 15,
        )
      ]),
    );
  }
}
