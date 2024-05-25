import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_training/repositories/settings/abstract_settings_repository.dart';

import '../../../repositories/settings/model/settings.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(this.settingsRepository) : super(SettingsInitial()) {
    on<LoadSettings>(_load);
    on<SaveSettings>(_save);
  }

  final AbstractSettingsRepository settingsRepository;

  Future<void> _load(LoadSettings event, Emitter<SettingsState> emit) async {
    try {
      if (state is! SettingsLoaded) {
        emit(SettingsLoading());
      }

      final settings = await settingsRepository.getUserSettings();
      emit(SettingsLoaded(settings: settings));
    } catch (e) {
      emit(SettingsError(message: e.toString()));
    }
  }

  Future<void> _save(SaveSettings event, Emitter<SettingsState> emit) async {
    try {
      settingsRepository.saveSettings(event.settings);
    } catch (e) {
      emit(SettingsError(message: e.toString()));
    }
  }
}
