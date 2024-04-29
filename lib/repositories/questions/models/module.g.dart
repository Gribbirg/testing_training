// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModuleAdapter extends TypeAdapter<Module> {
  @override
  final int typeId = 3;

  @override
  Module read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Module(
      name: fields[0] as String,
      questionsCount: fields[1] as int,
      dirName: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Module obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.questionsCount)
      ..writeByte(2)
      ..write(obj.dirName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModuleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Module _$ModuleFromJson(Map<String, dynamic> json) => Module(
      name: json['name'] as String,
      questionsCount: (json['questions_count'] as num).toInt(),
      dirName: json['dir_name'] as String,
    );

Map<String, dynamic> _$ModuleToJson(Module instance) => <String, dynamic>{
      'name': instance.name,
      'questions_count': instance.questionsCount,
      'dir_name': instance.dirName,
    };
