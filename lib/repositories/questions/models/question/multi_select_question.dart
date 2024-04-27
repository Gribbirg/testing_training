import 'package:json_annotation/json_annotation.dart';
import 'package:testing_training/repositories/questions/models/question/abstract_question.dart';
import 'package:testing_training/repositories/session_save/models/session_question.dart';

import 'answer.dart';

part 'multi_select_question.g.dart';

@JsonSerializable()
class MultiSelectQuestion extends AbstractQuestion {
  final String name;

  final int number;

  @JsonKey(name: "answers_count")
  final int answersCount;

  final String? image;

  @JsonKey(name: "right_answers_nums")
  final List<int> rightAnswersNumbers;

  final List<Answer> answers;

  factory MultiSelectQuestion.fromJson(Map<String, dynamic> json) =>
      _$MultiSelectQuestionFromJson(json);

  MultiSelectQuestion(
      {required this.name,
      required this.number,
      required this.answersCount,
      required this.image,
      required this.rightAnswersNumbers,
      required this.answers});

  Map<String, dynamic> toJson() => _$MultiSelectQuestionToJson(this);

  @override
  List<Object?> get props =>
      [name, number, answersCount, image, rightAnswersNumbers, answers];

  @override
  String? getImage() => image;

  @override
  String getName() => name;

  @override
  void setAnswerRight(SessionQuestion sessionQuestion) {
    final answer = sessionQuestion.userAnswer as List<bool>;
    for (int i = 0; i < answersCount; i++) {
      if (answer[i] != rightAnswersNumbers.contains(i)) {
        sessionQuestion.isRight = false;
        return;
      }
    }
    sessionQuestion.isRight = true;
  }

  @override
  void shuffleAnswersNum(SessionQuestion sessionQuestion) {
    final answersNum = [for (int i = 0; i < answersCount; i++) i];
    answersNum.shuffle();
    sessionQuestion.saveAnswersNum = answersNum;
    sessionQuestion.userAnswer = [for (int i = 0; i < answersCount; i++) false];
  }

  @override
  int getNumber() => number;

  @override
  bool isAnswerFilled(userAnswer) =>
      (userAnswer as List<bool>).any((element) => element);
}
