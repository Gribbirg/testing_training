import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'topic.g.dart';

@HiveType(typeId: 4)
@JsonSerializable()
class Topic extends Equatable {
  @HiveField(0)
  final String name;

  @HiveField(1)
  @JsonKey(name: "questions_count")
  final int questionsCount;

  @HiveField(2)
  @JsonKey(name: "dir_name")
  final String dirName;

  const Topic(this.name, this.questionsCount, this.dirName);

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);

  Map<String, dynamic> toJson() => _$TopicToJson(this);

  @override
  List<Object?> get props => [name, questionsCount, dirName];
}
