import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:testing_training/repositories/questions/models/question/abstract_question.dart';
import 'package:testing_training/repositories/session_save/models/session_question.dart';

part 'num_question.g.dart';

@HiveType(typeId: 9)
@JsonSerializable()
class NumQuestion extends AbstractQuestion {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int number;

  @HiveField(2)
  final String? image;

  @HiveField(3)
  final double answer;

  @HiveField(4)
  final double delta;

  @HiveField(5)
  final String unit;

  NumQuestion(
      {required this.name,
      required this.number,
      required this.image,
      required this.answer,
      required this.delta,
      required this.unit});

  factory NumQuestion.fromJson(Map<String, dynamic> json) =>
      _$NumQuestionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NumQuestionToJson(this);

  @override
  List<Object?> get props => [name, number, image, answer, delta, unit];

  @override
  String? getImage() => image;

  @override
  String getName() => name;

  @override
  void setAnswerRight(SessionQuestion sessionQuestion) {
    final userAnswer = double.parse(
        (sessionQuestion.userAnswer as String).replaceAll(',', '.'));
    sessionQuestion.isRight =
        userAnswer >= answer - delta && userAnswer <= answer + delta;
  }

  @override
  void shuffleAnswersNum(SessionQuestion sessionQuestion) {
    return;
  }

  @override
  int getNumber() => number;

  String getAnswerString() => (answer == answer.roundToDouble())
      ? answer.toInt().toString()
      : answer.toString();

  @override
  bool isAnswerFilled(userAnswer) => userAnswer != null;

  @override
  AbstractQuestion copyWithNum(int newNum) => NumQuestion(name: name, number: newNum, image: image, answer: answer, delta: delta, unit: unit);
}
