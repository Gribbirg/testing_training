
import 'package:hive/hive.dart';

part 'color_settings.g.dart';

@HiveType(typeId: 13)
class ColorSettings extends HiveObject {
  @HiveField(0)
  final int base;

  @HiveField(1)
  final ColorLightness lightness;

  @HiveField(2)
  final bool dynamic;

  ColorSettings(
      {required this.base, required this.lightness, required this.dynamic});

  ColorSettings.def(): this(
    base: 0xff406836,
    lightness: ColorLightness.system,
    dynamic: true
  );
}

@HiveType(typeId: 14)
enum ColorLightness {
  @HiveField(0)
  light,
  @HiveField(1)
  dark,
  @HiveField(2)
  system
}
