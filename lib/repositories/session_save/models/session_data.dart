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

  late int rightsCount;
  late int wrongCount;
  late int completeCount;

  int get questionsCount => sessionsQuestions.length;
  late int currentQuestionNum;

  SessionData(
      {required this.topicId, required this.moduleId, sessionsQuestions}) {
    this.sessionsQuestions = sessionsQuestions ?? [];
    rightsCount = 0;
    wrongCount = 0;
    completeCount = 0;
    currentQuestionNum =
        this.sessionsQuestions.indexWhere((element) => element.isRight == null);
    for (var element in this.sessionsQuestions) {
      if (element.isRight != null) {
        completeCount++;
        if (element.isRight!) {
          rightsCount++;
        } else {
          wrongCount++;
        }
      }
    }
  }

  bool allQuestionsAreClosed() =>
      !sessionsQuestions.any((element) => element.isRight == null);

  int getFirstOpenedIndex() =>
      sessionsQuestions.indexWhere((element) => element.isRight == null);
}
