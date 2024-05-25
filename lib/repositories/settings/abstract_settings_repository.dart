import 'package:testing_training/repositories/settings/model/settings.dart';

abstract class AbstractSettingsRepository {
  Future<Settings> getUserSettings();
  Future<void> saveSettings(Settings settings);
}