part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {}

class SettingsInitial extends SettingsState {
  @override
  List<Object?> get props => [];
}

class SettingsLoading extends SettingsState {
  @override
  List<Object?> get props => [];
}

class SettingsLoaded extends SettingsState {

  final Settings settings;

  SettingsLoaded({required this.settings});

  @override
  List<Object?> get props => [settings];
}

class SettingsError extends SettingsState {

  final String message;

  SettingsError({required this.message});

  @override
  List<Object?> get props => [];
}