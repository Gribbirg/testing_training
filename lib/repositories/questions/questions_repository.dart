import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:testing_training/repositories/questions/models/question/abstract_question.dart';

import 'abstract_questions_repository.dart';
import 'models/models.dart';
import 'models/question/questions_factory.dart';

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
  Future<List<Module>?> getModulesList(Topic topic) async {
    final String response = await rootBundle
        .loadString("$questionsPath/${topic.dirName}/modules.json");

    final data = await json.decode(response);

    final list =
        (data as List<dynamic>).map((e) => Module.fromJson(e)).toList();

    return list;
  }

  @override
  Future<List<AbstractQuestion>?> getQuestionsList(
      Topic topic, Module module) async {
    final String response = await rootBundle.loadString(
        "$questionsPath/${topic.dirName}/modules/${module.dirName}.json");

    final data = await json.decode(response);

    final list = (data as List<dynamic>).map((e) {
      return QuestionFactory.getQuestionFromJson(e);
    }).toList();

    return list;
  }
}
