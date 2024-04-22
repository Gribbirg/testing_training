import 'package:hive/hive.dart';

part 'session_question.g.dart';

@HiveType(typeId: 2)
class SessionQuestion extends HiveObject {

  @HiveField(0)
  final int questionNum;

  @HiveField(1)
  dynamic userAnswer;

  @HiveField(2)
  dynamic saveAnswersNum;

  @HiveField(3)
  bool? isRight;

  SessionQuestion({required this.questionNum});
}
