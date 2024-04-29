// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_question.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoriesQuestionAdapter extends TypeAdapter<CategoriesQuestion> {
  @override
  final int typeId = 7;

  @override
  CategoriesQuestion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoriesQuestion(
      name: fields[0] as String,
      number: fields[1] as int,
      answersCount: fields[2] as int,
      statementsCount: fields[3] as int,
      image: fields[4] as String?,
      rightAnswersNumbers: (fields[5] as List).cast<int>(),
      answers: (fields[7] as List).cast<Answer>(),
      statements: (fields[6] as List).cast<Answer>(),
    );
  }

  @override
  void write(BinaryWriter writer, CategoriesQuestion obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.number)
      ..writeByte(2)
      ..write(obj.answersCount)
      ..writeByte(3)
      ..write(obj.statementsCount)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.rightAnswersNumbers)
      ..writeByte(6)
      ..write(obj.statements)
      ..writeByte(7)
      ..write(obj.answers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoriesQuestionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
