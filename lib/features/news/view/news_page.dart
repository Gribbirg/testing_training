import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../widgets/adaptive_scaffold.dart';
import '../../../widgets/coming_soon_widget.dart';
import '../../../widgets/drawer.dart';

@RoutePage()
class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      scaffoldKey: _key,
      drawer: BaseDrawer(
        scaffoldKey: _key,
      ),
      appBarTitle: "Новости",
      body: const SingleChildScrollView(child: ComingSoonWidget()),
    );
  }
}
