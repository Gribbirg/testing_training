// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Answer _$AnswerFromJson(Map<String, dynamic> json) => Answer(
      text: json['text'] as String?,
      image: json['image'] as String?,
      number: json['number'] as int,
    );

Map<String, dynamic> _$AnswerToJson(Answer instance) => <String, dynamic>{
      'text': instance.text,
      'image': instance.image,
      'number': instance.number,
    };
