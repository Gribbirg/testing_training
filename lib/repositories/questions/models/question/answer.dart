import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'answer.g.dart';

@JsonSerializable()
class Answer extends Equatable {

  final String? text;

  final String? image;

  final int number;

  const Answer({required this.text, required this.image, required this.number});

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerToJson(this);

  @override
  List<Object?> get props => [text, image];
}