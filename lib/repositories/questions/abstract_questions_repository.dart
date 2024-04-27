import 'models/models.dart';

abstract class AbstractQuestionsRepository {
  Future<List<Topic>?> getTopicList();
  Future<List<Module>?> getModulesList(Topic topic);
  Future<List<AbstractQuestion>?> getQuestionsList(Topic topic, Module module);
}