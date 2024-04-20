import 'package:testing_training/repositories/topic_list/models/models.dart';

abstract class AbstractTopicListRepository {
  Future<List<Topic>?> getTopicList();
}