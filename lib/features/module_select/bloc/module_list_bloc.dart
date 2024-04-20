import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_training/repositories/module_list/abstract_module_list_repository.dart';
import 'package:testing_training/repositories/module_list/models/models.dart';
import 'package:testing_training/repositories/topic_list/models/models.dart';

part 'module_list_event.dart';

part 'module_list_state.dart';

class ModuleListBloc extends Bloc<ModuleListEvent, ModuleListState> {
  ModuleListBloc(this.topicListRepository) : super(ModuleListInitial()) {
    on<LoadModuleList>(_load);
  }

  final AbstractModuleListRepository topicListRepository;

  Future<void> _load(
      LoadModuleList event, Emitter<ModuleListState> emit) async {
    try {
      if (state is! ModuleListLoaded) {
        emit(ModuleListLoading());
      }

      if (event.topic == null) {
        emit(ModuleListLoading());
        return;
      }

      final modelsList = await topicListRepository.getModules(event.topic!);

      if (modelsList == null || modelsList.isEmpty) {
        emit(ModuleListError(message: "Темы не найдены"));
      } else {
        emit(ModuleListLoaded(modules: modelsList));
      }
    } catch (e) {
      emit(ModuleListError(message: e.toString()));
    }
  }
}
