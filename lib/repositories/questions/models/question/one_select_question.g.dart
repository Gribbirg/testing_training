// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'one_select_question.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OneSelectQuestionAdapter extends TypeAdapter<OneSelectQuestion> {
  @override
  final int typeId = 5;

  @override
  OneSelectQuestion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OneSelectQuestion(
      name: fields[0] as String,
      number: fields[1] as int,
      answersCount: fields[2] as int,
      image: fields[3] as String?,
      rightAnswerNumber: fields[4] as int,
      answers: (fields[5] as List).cast<Answer>(),
    );
  }

  @override
  void write(BinaryWriter writer, OneSelectQuestion obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.number)
      ..writeByte(2)
      ..write(obj.answersCount)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.rightAnswerNumber)
      ..writeByte(5)
      ..write(obj.answers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OneSelectQuestionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OneSelectQuestion _$OneSelectQuestionFromJson(Map<String, dynamic> json) =>
    OneSelectQuestion(
      name: json['name'] as String,
      number: (json['number'] as num).toInt(),
      answersCount: (json['answers_count'] as num).toInt(),
      image: json['image'] as String?,
      rightAnswerNumber: (json['right_ans_num'] as num).toInt(),
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
