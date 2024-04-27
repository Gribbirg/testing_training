// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_select_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultiSelectQuestion _$MultiSelectQuestionFromJson(Map<String, dynamic> json) =>
    MultiSelectQuestion(
      name: json['name'] as String,
      number: (json['number'] as num).toInt(),
      answersCount: (json['answers_count'] as num).toInt(),
      image: json['image'] as String?,
      rightAnswersNumbers: (json['right_answers_nums'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      answers: (json['answers'] as List<dynamic>)
          .map((e) => Answer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MultiSelectQuestionToJson(
        MultiSelectQuestion instance) =>
    <String, dynamic>{
      'name': instance.name,
      'number': instance.number,
      'answers_count': instance.answersCount,
      'image': instance.image,
      'right_answers_nums': instance.rightAnswersNumbers,
      'answers': instance.answers,
    };
