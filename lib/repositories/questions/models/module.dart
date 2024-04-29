import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'module.g.dart';

@HiveType(typeId: 3)
@JsonSerializable()
class Module extends Equatable {

  @HiveField(0)
  final String name;

  @HiveField(1)
  @JsonKey(name: "questions_count")
  final int questionsCount;

  @HiveField(2)
  @JsonKey(name: "dir_name")
  final String dirName;

  const Module({required this.name, required this.questionsCount, required this.dirName});

  factory Module.fromJson(Map<String, dynamic> json) => _$ModuleFromJson(json);

  Map<String, dynamic> toJson() => _$ModuleToJson(this);

  @override
  List<Object?> get props => [name, questionsCount, dirName];
}