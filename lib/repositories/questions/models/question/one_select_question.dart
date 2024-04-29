import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:testing_training/repositories/questions/models/question/abstract_question.dart';
import 'package:testing_training/repositories/session_save/models/session_question.dart';

import 'answer.dart';

part 'one_select_question.g.dart';

@HiveType(typeId: 5)
@JsonSerializable()
class OneSelectQuestion extends AbstractQuestion {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int number;

  @HiveField(2)
  @JsonKey(name: "answers_count")
  final int answersCount;

  @HiveField(3)
  final String? image;

  @HiveField(4)
  @JsonKey(name: "right_ans_num")
  final int rightAnswerNumber;

  @HiveField(5)
  final List<Answer> answers;

  factory OneSelectQuestion.fromJson(Map<String, dynamic> json) =>
      _$OneSelectQuestionFromJson(json);

  OneSelectQuestion(
      {required this.name,
      required this.number,
      required this.answersCount,
      required this.image,
      required this.rightAnswerNumber,
      required this.answers});

  @override
  Map<String, dynamic> toJson() => _$OneSelectQuestionToJson(this);

  @override
  List<Object?> get props =>
      [name, number, answersCount, image, rightAnswerNumber, answers];

  @override
  String? getImage() => image;

  @override
  String getName() => name;

  @override
  void setAnswerRight(SessionQuestion sessionQuestion) {
    final answer = sessionQuestion.userAnswer as int;
    sessionQuestion.isRight = answer == rightAnswerNumber;
  }

  @override
  void shuffleAnswersNum(SessionQuestion sessionQuestion) {
    final answersNum = [for (int i = 0; i < answersCount; i++) i];
    answersNum.shuffle();
    sessionQuestion.saveAnswersNum = answersNum;
  }

  @override
  int getNumber() => number;

  @override
  bool isAnswerFilled(userAnswer) => userAnswer != null;
}
