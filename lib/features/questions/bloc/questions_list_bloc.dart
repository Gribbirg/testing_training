import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_training/repositories/questions/models/models.dart';
import 'package:testing_training/repositories/session_save/abstract_session_save_repository.dart';
import 'package:testing_training/repositories/session_save/models/models.dart';
import 'package:testing_training/repositories/session_save/session_save.dart';

import '../../../repositories/questions/abstract_questions_repository.dart';
import '../../../repositories/questions/models/question/abstract_question.dart';

part 'questions_list_event.dart';

part 'questions_list_state.dart';

class QuestionsListBloc extends Bloc<QuestionsListEvent, QuestionsListState> {
  QuestionsListBloc(
      {required this.questionsRepository, required this.sessionSaveRepository})
      : super(QuestionsListInitial()) {
    on<LoadQuestionsList>(_load);
    on<SaveSessionData>(_save);
    on<DeleteSessionData>(_delete);
  }

  final AbstractQuestionsRepository questionsRepository;
  final AbstractSessionSaveRepository sessionSaveRepository;

  Future<void> _load(
      LoadQuestionsList event, Emitter<QuestionsListState> emit) async {
    try {
      if (state is! QuestionsListLoaded) {
        emit(QuestionsListLoading());
      }

      final topic = (await questionsRepository.getTopicList())
          ?.firstWhere((element) => element.dirName == event.topicId);

      if (topic == null) {
        emit(QuestionsListNotFound());
        return;
      }

      final module = (await questionsRepository.getModulesList(topic))
          ?.firstWhere((element) => element.dirName == event.moduleId);

      if (module == null) {
        emit(QuestionsListNotFound());
        return;
      }

      final questionsList =
          await questionsRepository.getQuestionsList(topic, module);

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

  Future<void> _delete(DeleteSessionData event, Emitter<QuestionsListState> emit) async {
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
}
