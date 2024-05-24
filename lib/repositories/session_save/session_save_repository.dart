import 'package:hive/hive.dart';
import 'package:testing_training/repositories/questions/models/module.dart';
import 'package:testing_training/repositories/questions/models/topic.dart';
import 'package:testing_training/repositories/session_save/abstract_session_save_repository.dart';
import 'package:testing_training/repositories/session_save/models/session_data.dart';

class SessionSaveRepository extends AbstractSessionSaveRepository {
  final LazyBox box;

  SessionSaveRepository({required this.box});

  @override
  Future<void> addSessionData(SessionData sessionData) async {
    box.put(_getKey(sessionData), sessionData);
  }

  @override
  Future<SessionData?> getSessionData(Topic topic, Module module) async {
    return (await box
            .get(_getKeyByTopicAndModule(topic.dirName, module.dirName)))
        as SessionData?;
    // return null;
  }

  @override
  Future<void> saveSessionData(SessionData sessionData) async {
    sessionData.save();
  }

  String _getKey(SessionData sessionData) =>
      '${sessionData.topicId}___${sessionData.moduleId}';

  String _getKeyByTopicAndModule(String topicId, String moduleId) =>
      '${topicId}___$moduleId';

  @override
  Future<void> removeSessionData(SessionData sessionData) async {
    sessionData.delete();
  }

  @override
  Future<void> removeAll() async {
    await box.clear();
  }

  @override
  Future<List<int>?> getTestingData(Topic topic) async {
    final data = await box.get(
        '${_getKeyByTopicAndModule(topic.dirName, 'testing')}___questions');
    if (data == null) return null;
    return (data as List<dynamic>).map((e) => e as int).toList();
  }

  @override
  Future<void> addTestingData(Topic topic, List<int> data) async {
    box.put('${_getKeyByTopicAndModule(topic.dirName, 'testing')}___questions',
        data);
  }

  @override
  Future<void> removeTestingData(String topicId) async {
    box.delete(
        '${_getKeyByTopicAndModule(topicId, 'testing')}___questions');
  }
}
