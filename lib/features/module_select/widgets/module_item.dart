import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testing_training/router/router.dart';

import '../../../repositories/questions/models/module.dart';
import '../../../repositories/questions/models/topic.dart';

class ModuleItem extends StatelessWidget {
  const ModuleItem({super.key, required this.module, required this.topic});

  final Topic topic;
  final Module module;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
        onPressed: () {
          AutoRouter.of(context).push(
              QuestionsRoute(topicId: topic.dirName, moduleId: module.dirName));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 10,
                child: Text(
                  module.name,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                flex: 4,
                child: Text(
                  "Кол-во: ${module.questionsCount}",
                  style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ));
  }
}
