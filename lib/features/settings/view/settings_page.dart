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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context, text: "Настройки", actions: [
        const Icon(Icons.settings),
        const SizedBox(
          width: 15,
        )
      ]),
    );
  }
}
