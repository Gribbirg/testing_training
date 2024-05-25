// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SessionDataAdapter extends TypeAdapter<SessionData> {
  @override
  final int typeId = 1;

  @override
  SessionData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SessionData(
      topicId: fields[0] as String,
      moduleId: fields[1] as String,
      sessionsQuestions: fields[2] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, SessionData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.topicId)
      ..writeByte(1)
      ..write(obj.moduleId)
      ..writeByte(2)
      ..write(obj.sessionsQuestions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
