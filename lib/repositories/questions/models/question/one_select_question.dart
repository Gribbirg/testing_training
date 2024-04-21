import 'package:json_annotation/json_annotation.dart';
import 'package:testing_training/repositories/questions/models/question/abstract_question.dart';

import 'answer.dart';

part 'one_select_question.g.dart';

@JsonSerializable()
class OneSelectQuestion extends AbstractQuestion {
  final String name;

  final int number;

  @JsonKey(name: "answers_count")
  final int answersCount;

  final String? image;

  @JsonKey(name: "right_ans_num")
  final int rightAnswerNumber;

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

  Map<String, dynamic> toJson() => _$OneSelectQuestionToJson(this);

  @override
  List<Object?> get props =>
      [name, number, answersCount, image, rightAnswerNumber, answers];

  @override
  String? getImage() => image;

  @override
  String getName() => name;
}
