import 'package:testing_training/repositories/questions/models/models.dart';

abstract class AbstractQuestionsCacheRepository {
  Future<bool> checkUpdates();

  Future<bool> hasTopicsData();

  Future<List<Topic>?> getTopicsData();

  Future<void> saveTopicsData(List<Topic> topics);

  Future<bool> hasModulesData(String topicId);

  Future<List<Module>?> getModulesData(String topicId);

  Future<void> saveModulesData(String topicId, List<Module> modules);

  Future<bool> hasQuestionsData(String topicId, String moduleId);

  Future<List<AbstractQuestion>?> getQuestionsData(
      String topicId, String moduleId);

  Future<void> saveQuestionsData(
      String topicId, String moduleId, List<AbstractQuestion> questions);

  Future<void> removeAll();
}
