import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_training/repositories/questions/models/models.dart';
import 'package:testing_training/repositories/questions_cache/questions_cache.dart';
import 'package:testing_training/repositories/session_save/abstract_session_save_repository.dart';
import 'package:testing_training/repositories/session_save/models/models.dart';
import 'package:testing_training/repositories/session_save/session_save.dart';

import '../../../repositories/questions/abstract_questions_repository.dart';

part 'questions_list_event.dart';

part 'questions_list_state.dart';

class QuestionsListBloc extends Bloc<QuestionsListEvent, QuestionsListState> {
  QuestionsListBloc(
      {required this.questionsCacheRepository,
      required this.questionsRepository,
      required this.sessionSaveRepository})
      : super(QuestionsListInitial()) {
    on<LoadQuestionsList>(_load);
    on<SaveSessionData>(_save);
    on<DeleteSessionData>(_delete);
    on<RestartSession>(_restart);
  }

  final AbstractQuestionsRepository questionsRepository;
  final AbstractSessionSaveRepository sessionSaveRepository;
  final AbstractQuestionsCacheRepository questionsCacheRepository;

  Future<void> _load(
      LoadQuestionsList event, Emitter<QuestionsListState> emit) async {
    try {
      if (state is! QuestionsListLoaded) {
        emit(QuestionsListLoading());
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
        emit(QuestionsListNotFound());
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

      final module = modelsList
          ?.firstWhere((element) => element.dirName == event.moduleId);
      if (module == null) {
        emit(QuestionsListNotFound());
        return;
      }

      List<AbstractQuestion>? questionsList;

      if (await questionsCacheRepository.hasQuestionsData(
          event.topicId!, event.moduleId!)) {
        questionsList = await questionsCacheRepository.getQuestionsData(
            event.topicId!, event.moduleId!);
      } else {
        questionsList =
            await questionsRepository.getQuestionsList(topic, module);
        if (questionsList != null) {
          questionsCacheRepository.saveQuestionsData(
              event.topicId!, event.moduleId!, questionsList);
        }
      }

      if (questionsList == null || questionsList.isEmpty) {
        emit(QuestionsListNotFound());
        return;
      }

      SessionData? sessionData =
          await sessionSaveRepository.getSessionData(topic, module);
      if (sessionData == null) {
        sessionData = SessionData(
            topicId: topic.dirName,
            moduleId: module.dirName,
            sessionsQuestions: _getShuffledQuestions(questionsList));
        await sessionSaveRepository.addSessionData(sessionData);
      }

      if (sessionData.sessionsQuestions.isEmpty) {
        emit(QuestionsListError(message: "Вопросы не найдены"));
      } else {
        emit(QuestionsListLoaded(
          topic: topic,
          module: module,
          questionsList: questionsList,
          sessionData: sessionData,
        ));
      }
    } catch (e) {
      emit(QuestionsListError(message: e.toString()));
    }
  }

  List<SessionQuestion> _getShuffledQuestions(
      List<AbstractQuestion> questionsList) {
    final sessionsQuestions = questionsList
        .map((e) => SessionQuestion(questionNum: e.getNumber()))
        .toList();

    for (var sessionQuestion in sessionsQuestions) {
      questionsList[sessionQuestion.questionNum]
          .shuffleAnswersNum(sessionQuestion);
    }

    sessionsQuestions.shuffle();

    return sessionsQuestions;
  }

  Future<void> _save(
      SaveSessionData event, Emitter<QuestionsListState> emit) async {
    try {
      if (state is! QuestionsListLoaded) {
        emit(QuestionsListError(message: "Nothing to save"));
        return;
      }
      sessionSaveRepository
          .saveSessionData((state as QuestionsListLoaded).sessionData);
    } catch (e) {
      emit(QuestionsListError(message: e.toString()));
    }
  }

  Future<void> _delete(
      DeleteSessionData event, Emitter<QuestionsListState> emit) async {
    try {
      if (state is! QuestionsListLoaded) {
        emit(QuestionsListError(message: "Nothing to save"));
        return;
      }
      sessionSaveRepository
          .removeSessionData((state as QuestionsListLoaded).sessionData);
    } catch (e) {
      emit(QuestionsListError(message: e.toString()));
    }
  }

  Future<void> _restart(
      RestartSession event, Emitter<QuestionsListState> emit) async {
    try {
      if (state is! QuestionsListLoaded) {
        emit(QuestionsListError(message: "Nothing to restart"));
        return;
      }
      final saveState = state as QuestionsListLoaded;
      emit(QuestionsListLoading());
      sessionSaveRepository.removeSessionData(saveState.sessionData);

      final session = SessionData(
        topicId: saveState.topic.dirName,
        moduleId: saveState.module.dirName,
      )..sessionsQuestions = _getShuffledQuestions(saveState.questionsList);
      emit(QuestionsListLoaded(
          topic: saveState.topic,
          module: saveState.module,
          questionsList: saveState.questionsList,
          sessionData: session));
      sessionSaveRepository.addSessionData(session);
    } catch (e) {
      emit(QuestionsListError(message: e.toString()));
    }
  }
}
