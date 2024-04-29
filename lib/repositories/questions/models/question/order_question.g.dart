// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_question.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderQuestionAdapter extends TypeAdapter<OrderQuestion> {
  @override
  final int typeId = 10;

  @override
  OrderQuestion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderQuestion(
      name: fields[0] as String,
      number: fields[1] as int,
      answersCount: fields[2] as int,
      image: fields[3] as String?,
      rightAnswersNumbersOrder: (fields[4] as List).cast<int>(),
      answers: (fields[5] as List).cast<Answer>(),
    );
  }

  @override
  void write(BinaryWriter writer, OrderQuestion obj) {
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
      ..write(obj.rightAnswersNumbersOrder)
      ..writeByte(5)
      ..write(obj.answers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderQuestionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderQuestion _$OrderQuestionFromJson(Map<String, dynamic> json) =>
    OrderQuestion(
      name: json['name'] as String,
      number: (json['number'] as num).toInt(),
      answersCount: (json['answers_count'] as num).toInt(),
      image: json['image'] as String?,
      rightAnswersNumbersOrder: (json['right_answers_nums'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      answers: (json['answers'] as List<dynamic>)
          .map((e) => Answer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderQuestionToJson(OrderQuestion instance) =>
    <String, dynamic>{
      'name': instance.name,
      'number': instance.number,
      'answers_count': instance.answersCount,
      'image': instance.image,
      'right_answers_nums': instance.rightAnswersNumbersOrder,
      'answers': instance.answers,
    };
