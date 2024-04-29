// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'string_question.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StringQuestionAdapter extends TypeAdapter<StringQuestion> {
  @override
  final int typeId = 11;

  @override
  StringQuestion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StringQuestion(
      name: fields[0] as String,
      number: fields[1] as int,
      image: fields[2] as String?,
      answer: fields[3] as String,
      variants: (fields[4] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, StringQuestion obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.number)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.answer)
      ..writeByte(4)
      ..write(obj.variants.toList());
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StringQuestionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StringQuestion _$StringQuestionFromJson(Map<String, dynamic> json) =>
    StringQuestion(
      name: json['name'] as String,
      number: (json['number'] as num).toInt(),
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
      'variants': instance.variants.toList(),
    };
