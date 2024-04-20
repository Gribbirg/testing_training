import '../topic_list/models/topic.dart';
import 'models/module.dart';

abstract class AbstractModuleListRepository {
  Future<List<Module>?> getModules(Topic topic);
}