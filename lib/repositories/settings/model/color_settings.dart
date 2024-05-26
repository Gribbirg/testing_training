import 'package:hive/hive.dart';

part 'color_settings.g.dart';

@HiveType(typeId: 13)
class ColorSettings extends HiveObject {
  @HiveField(0)
  int base;

  @HiveField(1)
  ColorLightness lightness;

  @HiveField(2)
  bool dynamic;

  ColorSettings(
      {required this.base, required this.lightness, required this.dynamic});

  ColorSettings.def()
      : this(base: 0xff406836, lightness: ColorLightness.system, dynamic: true);

  ColorSettings.copy(ColorSettings colorSettings)
      : this(
            base: colorSettings.base,
            lightness: colorSettings.lightness,
            dynamic: colorSettings.dynamic);

  @override
  String toString() {
    return 'ColorSettings{base: $base, lightness: $lightness, dynamic: $dynamic}';
  }
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

extension ColorLightnessNames on ColorLightness {
  String get ru {
    switch (this) {
      case ColorLightness.dark:
        return 'Тёмная';
      case ColorLightness.light:
        return 'Светлая';
      case ColorLightness.system:
        return 'Системная';
      default:
        return '';
    }
  }
}
