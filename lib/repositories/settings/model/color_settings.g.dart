// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color_settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ColorSettingAdapter extends TypeAdapter<ColorSettings> {
  @override
  final int typeId = 13;

  @override
  ColorSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ColorSettings(
      base: fields[0] as int,
      lightness: fields[1] as ColorLightness,
      dynamic: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ColorSettings obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.base)
      ..writeByte(1)
      ..write(obj.lightness)
      ..writeByte(2)
      ..write(obj.dynamic);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ColorSettingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ColorLightnessAdapter extends TypeAdapter<ColorLightness> {
  @override
  final int typeId = 14;

  @override
  ColorLightness read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ColorLightness.light;
      case 1:
        return ColorLightness.dark;
      case 2:
        return ColorLightness.system;
      default:
        return ColorLightness.light;
    }
  }

  @override
  void write(BinaryWriter writer, ColorLightness obj) {
    switch (obj) {
      case ColorLightness.light:
        writer.writeByte(0);
        break;
      case ColorLightness.dark:
        writer.writeByte(1);
        break;
      case ColorLightness.system:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ColorLightnessAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
