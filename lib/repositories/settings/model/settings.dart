import 'package:hive/hive.dart';

import 'color_settings.dart';

part 'settings.g.dart';

@HiveType(typeId: 12)
class Settings extends HiveObject {
  @HiveField(0)
  final ColorSettings colorSetting;

  @HiveField(1)
  late bool isDesktopDrawerOpened;

  Settings({required this.colorSetting, bool? isDesktopDrawerOpened}){
    this.isDesktopDrawerOpened = isDesktopDrawerOpened ?? true;
  }

  Settings.def()
      : this(colorSetting: ColorSettings.def(), isDesktopDrawerOpened: true);

  Settings.copy(Settings settings)
      : this(
            colorSetting: ColorSettings.copy(settings.colorSetting),
            isDesktopDrawerOpened: settings.isDesktopDrawerOpened);
}
