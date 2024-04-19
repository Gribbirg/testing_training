import 'package:flutter/material.dart';
import 'package:testing_training/repositories/topic_list/models/modules.dart';

class TopicItem extends StatelessWidget {
  const TopicItem({super.key, required this.topic});

  final Topic topic;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Text(topic.name),
          Text(topic.questionsCount.toString()),
        ],
      ),
    );
  }
}