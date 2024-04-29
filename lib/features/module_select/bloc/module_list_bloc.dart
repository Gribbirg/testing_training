import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_training/repositories/questions_cache/abstract_questions_cache_repository.dart';

import '../../../repositories/questions/abstract_questions_repository.dart';
import '../../../repositories/questions/models/module.dart';
import '../../../repositories/questions/models/topic.dart';

part 'module_list_event.dart';

part 'module_list_state.dart';

class ModuleListBloc extends Bloc<ModuleListEvent, ModuleListState> {
  ModuleListBloc(this.questionsRepository, this.questionsCacheRepository)
      : super(ModuleListInitial()) {
    on<LoadModuleList>(_load);
  }

  final AbstractQuestionsRepository questionsRepository;
  final AbstractQuestionsCacheRepository questionsCacheRepository;

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

      List<Topic>? topicList;
      if (await questionsCacheRepository.hasTopicsData()) {
        topicList = await questionsCacheRepository.getTopicsData();
      } else {
        topicList = await questionsRepository.getTopicList();
        if (topicList != null) {
          questionsCacheRepository.saveTopicsData(topicList);
        }
      }

      final topic =
          topicList?.firstWhere((element) => element.dirName == event.topicId);
      if (topic == null) {
        emit(ModuleListNotFound());
        return;
      }

      List<Module>? modelsList;
      if (await questionsCacheRepository.hasModulesData(event.topicId!)) {
        modelsList =
            await questionsCacheRepository.getModulesData(event.topicId!);
      } else {
        modelsList = await questionsRepository.getModulesList(topic);
        if (modelsList != null) {
          questionsCacheRepository.saveModulesData(event.topicId!, modelsList);
        }
      }

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
