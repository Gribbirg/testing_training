import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:testing_training/repositories/questions/models/question/abstract_question.dart';
import 'package:testing_training/repositories/session_save/models/session_question.dart';

import 'answer.dart';

part 'order_question.g.dart';

@HiveType(typeId: 10)
@JsonSerializable()
class OrderQuestion extends AbstractQuestion {
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
  @JsonKey(name: "right_answers_nums")
  final List<int> rightAnswersNumbersOrder;

  @HiveField(5)
  final List<Answer> answers;

  factory OrderQuestion.fromJson(Map<String, dynamic> json) =>
      _$OrderQuestionFromJson(json);

  OrderQuestion(
      {required this.name,
      required this.number,
      required this.answersCount,
      required this.image,
      required this.rightAnswersNumbersOrder,
      required this.answers});

  @override
  Map<String, dynamic> toJson() => _$OrderQuestionToJson(this);

  @override
  List<Object?> get props =>
      [name, number, answersCount, image, rightAnswersNumbersOrder, answers];

  @override
  String? getImage() => image;

  @override
  String getName() => name;

  @override
  void setAnswerRight(SessionQuestion sessionQuestion) {
    final answer = sessionQuestion.userAnswer as List<int>;
    sessionQuestion.isRight = listEquals(answer, rightAnswersNumbersOrder);
  }

  @override
  void shuffleAnswersNum(SessionQuestion sessionQuestion) {
    final answersNum = [for (int i = 0; i < answersCount; i++) i];
    answersNum.shuffle();
    sessionQuestion.saveAnswersNum = answersNum;
    sessionQuestion.userAnswer = List<int>.from(answersNum);
  }

  @override
  int getNumber() => number;

  @override
  bool isAnswerFilled(userAnswer) => true;
}
