import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:testing_training/repositories/topic_list/abstract_topic_list_repository.dart';
import 'package:testing_training/repositories/topic_list/models/topic.dart';

class TopicListRepository extends AbstractTopicListRepository {

  final String topicsListJsonPath;

  TopicListRepository({required this.topicsListJsonPath});

  @override
  Future<List<Topic>?> getTopicList() async {
    final String response =
        await rootBundle.loadString(topicsListJsonPath);

    final data = await json.decode(response);

    final list = (data as List<dynamic>).map((e) => Topic.fromJson(e)).toList();

    return list;
  }
}
