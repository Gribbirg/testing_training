// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Topic _$TopicFromJson(Map<String, dynamic> json) => Topic(
      json['name'] as String,
      json['questions_count'] as int,
      json['dir_name'] as String,
    );

Map<String, dynamic> _$TopicToJson(Topic instance) => <String, dynamic>{
      'name': instance.name,
      'questions_count': instance.questionsCount,
      'dir_name': instance.dirName,
    };
