import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testing_training/repositories/topic_list/models/topic.dart';
import 'package:testing_training/router/router.dart';

@RoutePage()
class ModuleSelectPage extends StatefulWidget {
  const ModuleSelectPage({super.key, this.topic});

  final Topic? topic;

  @override
  State<StatefulWidget> createState() => _ModuleSelectPageState();
}

class _ModuleSelectPageState extends State<ModuleSelectPage> {

  @override
  Widget build(BuildContext context) {

    if (widget.topic == null) {
      AutoRouter.of(context).popAndPush(const HomeRoute());
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.topic!.name),
      ),
    );
  }
}