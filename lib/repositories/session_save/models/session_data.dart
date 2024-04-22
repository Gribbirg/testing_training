import 'package:hive/hive.dart';
import 'package:testing_training/repositories/session_save/models/session_question.dart';

part 'session_data.g.dart';

@HiveType(typeId: 1)
class SessionData extends HiveObject {
  @HiveField(0)
  final String topicId;

  @HiveField(1)
  final String moduleId;

  @HiveField(2)
  late List<SessionQuestion> sessionsQuestions;

  SessionData(
      {required this.topicId, required this.moduleId, sessionsQuestions}) {
    this.sessionsQuestions = sessionsQuestions ?? [];
  }
}