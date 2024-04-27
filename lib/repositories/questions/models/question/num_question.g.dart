// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'num_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NumQuestion _$NumQuestionFromJson(Map<String, dynamic> json) => NumQuestion(
      name: json['name'] as String,
      number: (json['number'] as num).toInt(),
      image: json['image'] as String?,
      answer: (json['answer'] as num).toDouble(),
      delta: (json['delta'] as num).toDouble(),
      unit: json['unit'] as String,
    );

Map<String, dynamic> _$NumQuestionToJson(NumQuestion instance) =>
    <String, dynamic>{
      'name': instance.name,
      'number': instance.number,
      'image': instance.image,
      'answer': instance.answer,
      'delta': instance.delta,
      'unit': instance.unit,
    };
