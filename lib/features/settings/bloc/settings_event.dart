part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {}

class LoadSettings extends SettingsEvent {
  @override
  List<Object?> get props => [];
}

class SaveSettings extends SettingsEvent {
  final Settings settings;

  SaveSettings({required this.settings});
  @override
  List<Object?> get props => [];
}
