import 'package:hive/hive.dart';

import 'color_settings.dart';

part 'settings.g.dart';

@HiveType(typeId: 12)
class Settings extends HiveObject {
  @HiveField(0)
  final ColorSettings colorSetting;

  Settings({required this.colorSetting});

  Settings.def() : this(colorSetting: ColorSettings.def());

  Settings.copy(Settings settings) : this(colorSetting: ColorSettings.copy(settings.colorSetting));

  @override
  String toString() {
    return 'Settings{colorSetting: $colorSetting}';
  }
}
