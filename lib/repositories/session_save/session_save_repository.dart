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
    // return (await box.get(_getKeyByTopicAndModule(topic, module))) as SessionData?;
    return null;
  }

  @override
  Future<void> saveSessionData(SessionData sessionData) async {
    sessionData.save();
  }

  String _getKey(SessionData sessionData) =>
      '${sessionData.topicId}___${sessionData.moduleId}';

  String _getKeyByTopicAndModule(Topic topic, Module module) =>
      '${topic.dirName}___${module.dirName}';

  @override
  Future<void> removeSessionData(SessionData sessionData) async {
    sessionData.delete();
  }
}