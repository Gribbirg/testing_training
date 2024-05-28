import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

import '../../../repositories/questions/abstract_questions_repository.dart';
import '../../../repositories/questions/models/module.dart';
import '../../../repositories/questions/models/topic.dart';

part 'module_list_event.dart';

part 'module_list_state.dart';

class ModuleListBloc extends Bloc<ModuleListEvent, ModuleListState> {
  ModuleListBloc(this.questionsRepository,)
      : super(ModuleListInitial()) {
    on<LoadModuleList>(_load);
  }

  final AbstractQuestionsRepository questionsRepository;

  Future<void> _load(
      LoadModuleList event, Emitter<ModuleListState> emit) async {
    try {
      if (state is! ModuleListLoaded) {
        emit(ModuleListLoading());
      }

      if (event.topicId == null) {
        emit(ModuleListNotFound());
        return;
      }

      final topic = (await questionsRepository.getTopicList())
          ?.firstWhereOrNull((element) => element.dirName == event.topicId);
      if (topic == null) {
        emit(ModuleListNotFound());
        return;
      }

      final modelsList =
      await questionsRepository.getModulesList(event.topicId!);

      if (modelsList == null || modelsList.isEmpty) {
        emit(ModuleListError(message: "Темы не найдены"));
      } else {
        emit(ModuleListLoaded(topic: topic, modules: modelsList));
      }
    } catch (e) {
      emit(ModuleListError(message: e.toString()));
    }
  }
}
