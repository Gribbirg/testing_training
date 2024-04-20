import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'module.g.dart';

@JsonSerializable()
class Module extends Equatable {

  final String name;

  @JsonKey(name: "questions_count")
  final int questionsCount;

  @JsonKey(name: "dir_name")
  final String dirName;

  const Module({required this.name, required this.questionsCount, required this.dirName});

  factory Module.fromJson(Map<String, dynamic> json) => _$ModuleFromJson(json);

  Map<String, dynamic> toJson() => _$ModuleToJson(this);

  @override
  List<Object?> get props => [];
}