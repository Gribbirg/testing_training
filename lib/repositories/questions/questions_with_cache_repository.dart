import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:testing_training/repositories/questions/questions_cloud_repository.dart';
import 'package:version/version.dart';
import '../session_save/abstract_session_save_repository.dart';
import 'models/module.dart';
import 'models/question/abstract_question.dart';
import 'models/topic.dart';

class QuestionsCloudWithCacheRepository extends QuestionsCloudRepository {
  final LazyBox cacheBox;
  Version? _dataVersion;

  QuestionsCloudWithCacheRepository({required this.cacheBox});

  @override
  Future<List<AbstractQuestion>?> getQuestionsList(
      String topicId, String moduleId) async {
    List<AbstractQuestion>? questionsList;

    if (await _hasQuestionsData(topicId, moduleId)) {
      questionsList = await _getQuestionsData(topicId, moduleId);
    } else {
      questionsList = await super.getQuestionsList(topicId, moduleId);
      if (questionsList != null) {
        _saveQuestionsData(topicId, moduleId, questionsList);
      }
    }

    return questionsList;
  }

  @override
  Future<List<Module>?> getModulesList(String topicId) async {
    List<Module>? modelsList;
    if (await _hasModulesData(topicId)) {
      modelsList = await _getModulesData(topicId);
    } else {
      modelsList = await super.getModulesList(topicId);
      if (modelsList != null) {
        _saveModulesData(topicId, modelsList);
      }
    }
    return modelsList;
  }

  @override
  Future<List<Topic>?> getTopicList() async {
    List<Topic>? topicList;
    if (await _hasTopicsData()) {
      topicList = await _getTopicsData();
    } else {
      topicList = await super.getTopicList();
      if (topicList != null) {
        _saveTopicsData(topicList);
      }
    }
    return topicList;
  }

  Future<List<Module>?> _getModulesData(String topicId) async =>
      ((await cacheBox.get(topicId)) as List<dynamic>)
          .map((e) => e as Module)
          .toList();

  Future<List<AbstractQuestion>?> _getQuestionsData(
      String topicId, String moduleId) async {
    return ((await cacheBox.get('${topicId}___$moduleId')) as List).map((e) {
      return e as AbstractQuestion;
    }).toList();
  }

  Future<List<Topic>?> _getTopicsData() async =>
      ((await cacheBox.get('topics')) as List<dynamic>)
          .map((e) => e as Topic)
          .toList();

  Future<bool> _hasModulesData(String topicId) async =>
      cacheBox.containsKey(topicId);

  Future<bool> _hasQuestionsData(String topicId, String moduleId) async =>
      cacheBox.containsKey('${topicId}___$moduleId');

  Future<bool> _hasTopicsData() async => cacheBox.containsKey('topics');

  Future<bool> checkUpdates() async {
    final questionsRef =
        FirebaseStorage.instance.ref().child('questions').child('/update.json');
    Uint8List? downloadedData = await questionsRef.getData();
    final dataString = utf8.decode(downloadedData!);
    final data = (await json.decode(dataString)) as Map<String, dynamic>;

    // final updateData = DateTime.parse(data["time"]);
    // final lastUploadDate = DateTime.parse(
    //     ((await cacheBox.get("update_date")) as String?) ??
    //         "1974-03-20 00:00:00.000");
    // if (lastUploadDate.isBefore(updateData)) {
    //   await removeAll();
    //   await cacheBox.put("update_date", DateTime.now().toUtc().toIso8601String());
    //   await GetIt.I<AbstractSessionSaveRepository>().removeAll();
    //   return true;
    // }

    _dataVersion = Version.parse(data["version"]);
    final localVersion =
        Version.parse((await cacheBox.get("version") as String?) ?? "0.0.0");

    if (_dataVersion != localVersion) {
      await removeAll();
      await cacheBox.put("version", _dataVersion.toString());
      await GetIt.I<AbstractSessionSaveRepository>().removeAll();
    }
    return false;
  }

  Future<void> _saveModulesData(String topicId, List<Module> modules) async {
    await cacheBox.put(topicId, modules);
  }

  Future<void> _saveQuestionsData(
      String topicId, String moduleId, List<AbstractQuestion> questions) async {
    await cacheBox.put('${topicId}___$moduleId', questions);
  }

  Future<void> _saveTopicsData(List<Topic> topics) async {
    await cacheBox.put('topics', topics);
  }

  Future<void> removeAll() async {
    await cacheBox.clear();
  }

  @override
  Version get version => _dataVersion!;
}
