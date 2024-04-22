// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_question.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SessionQuestionAdapter extends TypeAdapter<SessionQuestion> {
  @override
  final int typeId = 2;

  @override
  SessionQuestion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SessionQuestion(
      questionNum: fields[0] as int,
    )
      ..userAnswer = fields[1] as dynamic
      ..saveAnswersNum = fields[2] as dynamic
      ..isRight = fields[3] as bool?;
  }

  @override
  void write(BinaryWriter writer, SessionQuestion obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.questionNum)
      ..writeByte(1)
      ..write(obj.userAnswer)
      ..writeByte(2)
      ..write(obj.saveAnswersNum)
      ..writeByte(3)
      ..write(obj.isRight);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionQuestionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
