import 'package:json_annotation/json_annotation.dart';
import 'package:testing_training/repositories/questions/models/question/abstract_question.dart';
import 'package:testing_training/repositories/session_save/models/session_question.dart';

part 'string_question.g.dart';

@JsonSerializable()
class StringQuestion extends AbstractQuestion {
  final String name;

  final int number;

  final String? image;

  final String answer;

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
}
