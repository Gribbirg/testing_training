// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'num_question.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NumQuestionAdapter extends TypeAdapter<NumQuestion> {
  @override
  final int typeId = 9;

  @override
  NumQuestion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NumQuestion(
      name: fields[0] as String,
      number: fields[1] as int,
      image: fields[2] as String?,
      answer: fields[3] as double,
      delta: fields[4] as double,
      unit: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NumQuestion obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.number)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.answer)
      ..writeByte(4)
      ..write(obj.delta)
      ..writeByte(5)
      ..write(obj.unit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NumQuestionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
