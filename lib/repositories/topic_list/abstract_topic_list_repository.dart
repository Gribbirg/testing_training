import 'package:testing_training/repositories/topic_list/models/modules.dart';

abstract class AbstractTopicListRepository {
  Future<List<Topic>?> getTopicList();
}