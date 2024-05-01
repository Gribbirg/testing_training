import 'dart:convert';

import 'package:flutter/services.dart';

import 'abstract_questions_repository.dart';
import 'models/models.dart';

class QuestionsRepository extends AbstractQuestionsRepository {
  final String topicsListJsonPath;
  final String questionsPath;

  QuestionsRepository(
      {required this.questionsPath, required this.topicsListJsonPath});

  @override
  Future<List<Topic>?> getTopicList() async {
    final String response = await rootBundle.loadString(topicsListJsonPath);

    final data = await json.decode(response);

    final list = (data as List<dynamic>).map((e) => Topic.fromJson(e)).toList();

    return list;
  }

  @override
  Future<List<Module>?> getModulesList(String topicId) async {
    final String response = await rootBundle
        .loadString("$questionsPath/$topicId/modules.json");

    final data = await json.decode(response);

    final list =
        (data as List<dynamic>).map((e) => Module.fromJson(e)).toList();

    return list;
  }

  @override
  Future<List<AbstractQuestion>?> getQuestionsList(
      String topicId, String moduleId) async {
    final String response = await rootBundle.loadString(
        "$questionsPath/$topicId/modules/$moduleId.json");

    final data = await json.decode(response);

    final list = (data as List<dynamic>).map((e) {
      return QuestionFactory.getQuestionFromJson(e);
    }).toList();

    return list;
  }
}
