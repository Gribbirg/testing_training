// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Module _$ModuleFromJson(Map<String, dynamic> json) => Module(
      name: json['name'] as String,
      questionsCount: json['questions_count'] as int,
      dirName: json['dir_name'] as String,
    );

Map<String, dynamic> _$ModuleToJson(Module instance) => <String, dynamic>{
      'name': instance.name,
      'questions_count': instance.questionsCount,
      'dir_name': instance.dirName,
    };
