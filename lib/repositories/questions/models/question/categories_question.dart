import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:testing_training/repositories/questions/models/question/abstract_question.dart';
import 'package:testing_training/repositories/session_save/models/session_question.dart';

import 'answer.dart';

part 'categories_question.g.dart';

@JsonSerializable()
class CategoriesQuestion extends AbstractQuestion {
  final String name;

  final int number;

  @JsonKey(name: "answers_count")
  final int answersCount;

  @JsonKey(name: "statements_count")
  final int statementsCount;

  final String? image;

  @JsonKey(name: "right_answers_nums")
  final List<int> rightAnswersNumbers;

  final List<Answer> statements;

  final List<Answer> answers;

  factory CategoriesQuestion.fromJson(Map<String, dynamic> json) =>
      _$CategoriesQuestionFromJson(json);

  CategoriesQuestion({
    required this.name,
    required this.number,
    required this.answersCount,
    required this.statementsCount,
    required this.image,
    required this.rightAnswersNumbers,
    required this.answers,
    required this.statements,
  });

  @override
  void setAnswerRight(SessionQuestion sessionQuestion) {
    final answer = (sessionQuestion.userAnswer as List).cast<int?>();
    sessionQuestion.isRight = listEquals(answer, rightAnswersNumbers);
  }

  @override
  void shuffleAnswersNum(SessionQuestion sessionQuestion) {
    sessionQuestion.saveAnswersNum = [
      [for (int i = 0; i < statementsCount; i++) i]..shuffle(),
      [for (int i = 0; i < answersCount; i++) i]..shuffle()
    ];
    sessionQuestion.userAnswer = <int?>[
      for (int i = 0; i < statementsCount; i++) null
    ];
  }

  Map<String, dynamic> toJson() => _$CategoriesQuestionToJson(this);

  @override
  List<Object?> get props => [
        name,
        number,
        answersCount,
        image,
        rightAnswersNumbers,
        answers,
        statements,
        statementsCount
      ];

  @override
  String? getImage() => image;

  @override
  String getName() => name;

  @override
  int getNumber() => number;

  @override
  bool isAnswerFilled(userAnswer) =>
      !(userAnswer as List).any((element) => element == null);
}
