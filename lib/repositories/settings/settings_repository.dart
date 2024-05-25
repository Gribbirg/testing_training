import 'package:hive_flutter/adapters.dart';
import 'package:testing_training/repositories/settings/abstract_settings_repository.dart';
import 'package:testing_training/repositories/settings/model/settings.dart';

class SettingRepository extends AbstractSettingsRepository {

  final Box box;

  SettingRepository({required this.box});

  @override
  Future<Settings> getUserSettings() async {
    Settings? settings = await box.get('user_settings');
    if (settings == null) {
      settings = Settings.def();
      await box.put('user_settings', settings);
    }
    return settings;
  }

  @override
  Future<void> saveSettings(Settings settings) async {
    settings.save();
  }
}