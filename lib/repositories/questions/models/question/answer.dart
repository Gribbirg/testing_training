import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'answer.g.dart';

@HiveType(typeId: 6)
@JsonSerializable()
class Answer extends Equatable {
  @HiveField(0)
  final String? text;
  @HiveField(1)
  final String? image;
  @HiveField(2)
  final int number;

  const Answer({required this.text, required this.image, required this.number});

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerToJson(this);

  @override
  List<Object?> get props => [text, image, number];
}
