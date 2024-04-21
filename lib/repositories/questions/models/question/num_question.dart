import 'package:json_annotation/json_annotation.dart';
import 'package:testing_training/repositories/questions/models/question/abstract_question.dart';

part 'num_question.g.dart';

@JsonSerializable()
class NumQuestion extends AbstractQuestion {

  final String name;

  final int number;

  final String? image;

  final double answer;

  final double delta;

  final String unit;

  NumQuestion({required this.name, required this.number, required this.image, required this.answer, required this.delta, required this.unit});

  factory NumQuestion.fromJson(Map<String, dynamic> json) => _$NumQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$NumQuestionToJson(this);

  @override
  List<Object?> get props => [name, number, image, answer, delta, unit];

  @override
  String? getImage() => image;

  @override
  String getName() => name;
}