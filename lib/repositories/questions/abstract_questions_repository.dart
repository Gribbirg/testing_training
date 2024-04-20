import 'models/models.dart';
import 'models/question/abstract_question.dart';

abstract class AbstractQuestionsRepository {
  Future<List<Topic>?> getTopicList();
  Future<List<Module>?> getModulesList(Topic topic);
  Future<List<AbstractQuestion>?> getQuestionsList(Topic topic, Module module);
}