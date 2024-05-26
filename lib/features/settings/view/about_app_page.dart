import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:testing_training/widgets/app_bar.dart';
import 'package:testing_training/widgets/coming_soon_widget.dart';

import '../../../widgets/adaptive_scaffold.dart';
import '../widgets/settings_drawer.dart';

@RoutePage()
class AboutAppPage extends StatefulWidget {
  const AboutAppPage({super.key});

  @override
  State<AboutAppPage> createState() => _AboutAppPageState();
}

class _AboutAppPageState extends State<AboutAppPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      scaffoldKey: _key,
      drawer: SettingsDrawer(scaffoldKey: _key),
      appBar: getAppBar(context, text: 'О приложении'),
      body: const SingleChildScrollView(
        child: ComingSoonWidget(),
      ),
    );
  }
}
