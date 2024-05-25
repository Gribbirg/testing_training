import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../widgets/app_bar.dart';
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
    return Scaffold(
      key: _key,
      drawer: BaseDrawer(
        scaffoldKey: _key,
      ),
      appBar: getAppBar(context, text: "Новости"),
      body: const SingleChildScrollView(child: ComingSoonWidget()),
    );
  }
}
