import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:testing_training/repositories/topic_list/models/modules.dart';

class TopicItem extends StatelessWidget {
  const TopicItem({super.key, required this.topic});

  final Topic topic;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
        onPressed: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 10,
                child: Text(
                  topic.name,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  "Вопросов: ${topic.questionsCount}",
                  style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
                ),
              ),
            ],
          ),
        ));
  }
}
