// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriesQuestion _$CategoriesQuestionFromJson(Map<String, dynamic> json) =>
    CategoriesQuestion(
      name: json['name'] as String,
      number: (json['number'] as num).toInt(),
      answersCount: (json['answers_count'] as num).toInt(),
      statementsCount: (json['statements_count'] as num).toInt(),
      image: json['image'] as String?,
      rightAnswersNumbers: (json['right_answers_nums'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      answers: (json['answers'] as List<dynamic>)
          .map((e) => Answer.fromJson(e as Map<String, dynamic>))
          .toList(),
      statements: (json['statements'] as List<dynamic>)
          .map((e) => Answer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoriesQuestionToJson(CategoriesQuestion instance) =>
    <String, dynamic>{
      'name': instance.name,
      'number': instance.number,
      'answers_count': instance.answersCount,
      'statements_count': instance.statementsCount,
      'image': instance.image,
      'right_answers_nums': instance.rightAnswersNumbers,
      'statements': instance.statements,
      'answers': instance.answers,
    };
