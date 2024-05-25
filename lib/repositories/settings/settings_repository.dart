import 'package:hive_flutter/adapters.dart';
import 'package:testing_training/repositories/settings/abstract_settings_repository.dart';
import 'package:testing_training/repositories/settings/model/settings.dart';

class SettingRepository extends AbstractSettingsRepository {

  final LazyBox box;

  SettingRepository({required this.box});

  @override
  Future<Settings> getUserSettings() async {
    return (await box.get('user_settings')) as Settings? ?? Settings.def();
  }

  @override
  Future<void> saveSettings(Settings settings) async {
    box.put('user_settings', settings);
  }
}