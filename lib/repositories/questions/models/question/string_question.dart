import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:testing_training/repositories/questions/models/question/abstract_question.dart';
import 'package:testing_training/repositories/session_save/models/session_question.dart';

part 'string_question.g.dart';

@HiveType(typeId: 11)
@JsonSerializable()
class StringQuestion extends AbstractQuestion {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int number;

  @HiveField(2)
  final String? image;

  @HiveField(3)
  final String answer;

  @HiveField(4)
  late final Set<String> variants;

  StringQuestion(
      {required this.name,
      required this.number,
      required this.image,
      required this.answer,
      required List<String> variants}) {
    this.variants = variants.map((e) => e.toLowerCase()).toSet();
  }

  factory StringQuestion.fromJson(Map<String, dynamic> json) =>
      _$StringQuestionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StringQuestionToJson(this);

  @override
  List<Object?> get props => [name, number, image, answer, variants];

  @override
  String? getImage() => image;

  @override
  String getName() => name;

  @override
  void setAnswerRight(SessionQuestion sessionQuestion) {
    final userAnswer = (sessionQuestion.userAnswer as String).toLowerCase();
    sessionQuestion.isRight =
        userAnswer == answer.toLowerCase() || variants.contains(userAnswer);
  }

  @override
  void shuffleAnswersNum(SessionQuestion sessionQuestion) {
    return;
  }

  @override
  int getNumber() => number;

  @override
  bool isAnswerFilled(userAnswer) => userAnswer != null;

  @override
  AbstractQuestion copyWithNum(int newNum) => StringQuestion(name: name, number: newNum, image: image, answer: answer, variants: variants.toList());
}
