// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'one_select_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OneSelectQuestion _$OneSelectQuestionFromJson(Map<String, dynamic> json) =>
    OneSelectQuestion(
      name: json['name'] as String,
      number: json['number'] as int,
      answersCount: json['answers_count'] as int,
      image: json['image'] as String?,
      rightAnswerNumber: json['right_ans_num'] as int,
      answers: (json['answers'] as List<dynamic>)
          .map((e) => Answer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OneSelectQuestionToJson(OneSelectQuestion instance) =>
    <String, dynamic>{
      'name': instance.name,
      'number': instance.number,
      'answers_count': instance.answersCount,
      'image': instance.image,
      'right_ans_num': instance.rightAnswerNumber,
      'answers': instance.answers,
    };
