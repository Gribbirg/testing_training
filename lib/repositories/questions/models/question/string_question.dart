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

  final List<String> variants;

  StringQuestion({required this.name, required this.number, required this.image, required this.answer, required this.variants});

  factory StringQuestion.fromJson(Map<String, dynamic> json) => _$StringQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$StringQuestionToJson(this);

  @override
  List<Object?> get props => [name, number, image, answer, variants];

  @override
  String? getImage() => image;

  @override
  String getName() => name;

  @override
  void setAnswer(SessionQuestion sessionQuestion) {
    // TODO: implement setAnswer
  }

  @override
  void shuffleAnswersNum(SessionQuestion sessionQuestion) {
    // TODO: implement shuffleAnswersNum
  }

  @override
  int getNumber() => number;
}