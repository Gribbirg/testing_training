import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'topic.g.dart';

@JsonSerializable()
class Topic extends Equatable {
  final String name;

  @JsonKey(name: "questions_count")
  final int questionsCount;

  @JsonKey(name: "dir_name")
  final String dirName;

  const Topic(this.name, this.questionsCount, this.dirName);

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);

  Map<String, dynamic> toJson() => _$TopicToJson(this);

  @override
  List<Object?> get props => [name, questionsCount, dirName];
}
