// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'string_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StringQuestion _$StringQuestionFromJson(Map<String, dynamic> json) =>
    StringQuestion(
      name: json['name'] as String,
      number: json['number'] as int,
      image: json['image'] as String?,
      answer: json['answer'] as String,
      variants:
          (json['variants'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$StringQuestionToJson(StringQuestion instance) =>
    <String, dynamic>{
      'name': instance.name,
      'number': instance.number,
      'image': instance.image,
      'answer': instance.answer,
      'variants': instance.variants,
    };
