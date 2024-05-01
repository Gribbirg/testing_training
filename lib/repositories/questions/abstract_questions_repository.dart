import 'models/models.dart';

abstract class AbstractQuestionsRepository {
  Future<List<Topic>?> getTopicList();
  Future<List<Module>?> getModulesList(String topicId);
  Future<List<AbstractQuestion>?> getQuestionsList(String topicId, String moduleId);
}