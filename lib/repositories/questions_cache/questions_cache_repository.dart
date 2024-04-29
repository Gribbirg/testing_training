import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:hive/hive.dart';
import 'package:testing_training/repositories/questions/models/models.dart';
import 'package:testing_training/repositories/questions_cache/abstract_questions_cache_repository.dart';

class QuestionsCacheRepository extends AbstractQuestionsCacheRepository {
  final LazyBox box;

  QuestionsCacheRepository({required this.box});

  @override
  Future<List<Module>?> getModulesData(String topicId) async =>
      ((await box.get(topicId)) as List<dynamic>)
          .map((e) => e as Module)
          .toList();

  @override
  Future<List<AbstractQuestion>?> getQuestionsData(
      String topicId, String moduleId) async {
    return ((await box.get('${topicId}___$moduleId')) as List).map((e) {
      return e as AbstractQuestion;
    }).toList();
  }

  @override
  Future<List<Topic>?> getTopicsData() async =>
      ((await box.get('topics')) as List<dynamic>)
          .map((e) => e as Topic)
          .toList();

  @override
  Future<bool> hasModulesData(String topicId) async => box.containsKey(topicId);

  @override
  Future<bool> hasQuestionsData(String topicId, String moduleId) async =>
      box.containsKey('${topicId}___$moduleId');

  @override
  Future<bool> hasTopicsData() async => box.containsKey('topics');

  @override
  Future<bool> checkUpdates() async {
    final questionsRef = FirebaseStorage.instance.ref().child('questions').child('/update.json');
    Uint8List? downloadedData = await questionsRef.getData();
    final dataString = utf8.decode(downloadedData!);
    final data = (await json.decode(dataString)) as Map<String, dynamic>;

    final updateData = DateTime.parse(data["time"]);
    final lastUploadDate = DateTime.parse(
        ((await box.get("update_date")) as String?) ??
            "1974-03-20 00:00:00.000");
    print(updateData);
    print(lastUploadDate);
    if (lastUploadDate.isBefore(updateData)) {
      await removeAll();
      await box.put("update_date", DateTime.now().toIso8601String());
      return true;
    }
    return false;
  }

  @override
  Future<void> saveModulesData(String topicId, List<Module> modules) async {
    await box.put(topicId, modules);
  }

  @override
  Future<void> saveQuestionsData(
      String topicId, String moduleId, List<AbstractQuestion> questions) async {
    await box.put('${topicId}___$moduleId', questions);
  }

  @override
  Future<void> saveTopicsData(List<Topic> topics) async {
    await box.put('topics', topics);
  }

  @override
  Future<void> removeAll() async {
    await box.clear();
  }
}
