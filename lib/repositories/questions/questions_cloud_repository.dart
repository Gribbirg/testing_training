import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:testing_training/repositories/questions/abstract_questions_repository.dart';
import 'package:testing_training/repositories/questions/models/module.dart';
import 'package:testing_training/repositories/questions/models/question/abstract_question.dart';
import 'package:testing_training/repositories/questions/models/topic.dart';

import 'models/question/questions_factory.dart';

class QuestionsCloudRepository extends AbstractQuestionsRepository {
  QuestionsCloudRepository();

  @override
  Future<List<Module>?> getModulesList(String topicId) async {
    final moduleRef = FirebaseStorage.instance
        .ref()
        .child('questions')
        .child(topicId)
        .child('/modules.json');
    Uint8List? downloadedData = await moduleRef.getData();
    final dataString = utf8.decode(downloadedData!);

    final data = await json.decode(dataString);

    final list =
        (data as List<dynamic>).map((e) => Module.fromJson(e)).toList();

    return list;
  }

  @override
  Future<List<AbstractQuestion>?> getQuestionsList(
      String topicId, String moduleId) async {
    final questionsRef = FirebaseStorage.instance
        .ref()
        .child('questions')
        .child(topicId)
        .child('modules')
        .child('/$moduleId.json');
    Uint8List? downloadedData = await questionsRef.getData();
    final dataString = utf8.decode(downloadedData!);

    final data = await json.decode(dataString);

    final list = (data as List<dynamic>).map((e) {
      return QuestionFactory.getQuestionFromJson(e);
    }).toList();

    return list;
  }

  @override
  Future<List<Topic>?> getTopicList() async {
    final topicRef =
        FirebaseStorage.instance.ref().child('questions').child('/topics.json');
    Uint8List? downloadedData = await topicRef.getData();
    final dataString = utf8.decode(downloadedData!);

    final data = await json.decode(dataString);

    final list = (data as List<dynamic>).map((e) => Topic.fromJson(e)).toList();

    return list;
  }
}
