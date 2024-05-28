import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:testing_training/log/abstract_logger.dart';
import 'package:testing_training/repositories/questions/models/models.dart';
import 'package:testing_training/repositories/session_save/abstract_session_save_repository.dart';
import 'package:testing_training/repositories/session_save/models/models.dart';
import 'package:testing_training/repositories/session_save/session_save.dart';

import '../../../repositories/questions/abstract_questions_repository.dart';

part 'questions_list_event.dart';

part 'questions_list_state.dart';

class QuestionsListBloc extends Bloc<QuestionsListEvent, QuestionsListState> {
  QuestionsListBloc(
      {required this.questionsRepository, required this.sessionSaveRepository})
      : super(QuestionsListInitial()) {
    on<LoadQuestionsList>(_load);
    on<SaveSessionData>(_save);
    on<DeleteSessionData>(_delete);
    on<RestartSession>(_restart);
    on<QuestionsFinishEvent>(_finish);
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
          ?.firstWhereOrNull((element) => element.dirName == event.topicId);

      if (topic == null) {
        emit(QuestionsListNotFound());
        return;
      }

      Module? module;
      List<AbstractQuestion>? questionsList;

      if (event.moduleId == 'testing') {
        module =
            const Module(name: 'Тест', questionsCount: 30, dirName: 'testing');
        questionsList = await _getTestingQuestions(emit, topic);
      } else {
        module = (await questionsRepository.getModulesList(event.topicId!))
            ?.firstWhereOrNull((element) => element.dirName == event.moduleId);
        if (module == null) {
          emit(QuestionsListNotFound());
          return;
        }
        questionsList = await questionsRepository.getQuestionsList(
            event.topicId!, event.moduleId!);
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

  Future<List<AbstractQuestion>> _getTestingQuestions(
      Emitter<QuestionsListState> emit, Topic topic) async {
    final List<Module>? modules =
        await questionsRepository.getModulesList(topic.dirName);
    if (modules == null) {
      emit(QuestionsListError(message: "Вопросы не найдены"));
      return [];
    }

    List<int>? questionsNumsList =
        await sessionSaveRepository.getTestingData(topic);
    if (questionsNumsList == null) {
      questionsNumsList = _getRandomNums(topic.questionsCount, 30);
      sessionSaveRepository.addTestingData(topic, questionsNumsList);
    }

    Map<String, List<int>>? questionsNums;
    questionsNums = <String, List<int>>{};

    for (int num in questionsNumsList) {
      int i = 0;
      while (modules[i].questionsCount <= num) {
        num -= modules[i].questionsCount;
        i++;
      }
      questionsNums[modules[i].dirName] =
          (questionsNums[modules[i].dirName] ?? <int>[])..add(num);
    }

    List<AbstractQuestion> questions = [];
    for (final entry in questionsNums.entries) {
      final moduleQuestions =
          await questionsRepository.getQuestionsList(topic.dirName, entry.key);
      if (moduleQuestions == null) {
        emit(QuestionsListError(message: "Вопросы не найдены"));
        return [];
      }

      questions.addAll(entry.value.map((e) => moduleQuestions[e]));
    }

    for (int i = 0; i < questions.length; i++) {
      questions[i] = questions[i].copyWithNum(i);
    }

    return questions;
  }

  List<int> _getRandomNums(int max, int count) {
    final random = Random();
    final nums = HashSet<int>();

    for (int i = 0; i < count; i++) {
      int num;
      do {
        num = random.nextInt(max);
      } while (nums.contains(num));
      nums.add(num);
    }

    return nums.toList()..shuffle();
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
      SessionData sessionData;
      if (state is QuestionsListLoaded) {
        sessionData = (state as QuestionsListLoaded).sessionData;
      } else if (state is QuestionsFinishState) {
        sessionData = (state as QuestionsFinishState).sessionData;
      } else {
        emit(QuestionsListError(message: "Nothing to delete"));
        return;
      }
      sessionSaveRepository.removeSessionData(sessionData);
      if (sessionData.moduleId == 'testing') {
        sessionSaveRepository.removeTestingData(sessionData.topicId);
      }
    } catch (e) {
      emit(QuestionsListError(message: e.toString()));
    }
  }

  Future<void> _restart(
      RestartSession event, Emitter<QuestionsListState> emit) async {
    try {
      if (state is! QuestionsListLoaded) {
        await sessionSaveRepository.removeSessionData(event.sessionData);
        await _load(
            LoadQuestionsList(
                topicId: event.sessionData.topicId,
                moduleId: event.sessionData.moduleId),
            emit);
        return;
      }
      final saveState = state as QuestionsListLoaded;
      emit(QuestionsListLoading());

      List<AbstractQuestion> questionsList = saveState.questionsList;

      sessionSaveRepository.removeSessionData(saveState.sessionData);
      if (saveState.sessionData.moduleId == 'testing') {
        sessionSaveRepository.removeTestingData(saveState.sessionData.topicId);
        questionsList = await _getTestingQuestions(emit, saveState.topic);
      }

      final session = SessionData(
        topicId: saveState.topic.dirName,
        moduleId: saveState.module.dirName,
      )..sessionsQuestions = _getShuffledQuestions(questionsList);
      emit(QuestionsListLoaded(
          topic: saveState.topic,
          module: saveState.module,
          questionsList: questionsList,
          sessionData: session));
      sessionSaveRepository.addSessionData(session);

      GetIt.I<AbstractLogger>().logEvent("restart_testng", {
        "right_answers": saveState.sessionData.rightsCount,
        "wrong_answers": saveState.sessionData.wrongCount,
        "no_ans_count": saveState.sessionData.questionsCount -
            saveState.sessionData.completeCount,
        "topic_id": saveState.topic.dirName,
        "module_id": saveState.module.dirName,
      });
    } catch (e) {
      emit(QuestionsListError(message: e.toString()));
    }
  }

  Future<void> _finish(
      QuestionsFinishEvent event, Emitter<QuestionsListState> emit) async {
    if (state is! QuestionsListLoaded) {
      emit(QuestionsListError(message: "Nothing to finish"));
      return;
    }
    final curState = state as QuestionsListLoaded;
    emit(QuestionsListLoading());

    emit(QuestionsFinishState(
        topic: curState.topic,
        module: curState.module,
        sessionData: curState.sessionData));

    GetIt.I<AbstractLogger>().logEvent("finish_testng", {
      "right_answers": curState.sessionData.rightsCount,
      "wrong_answers": curState.sessionData.wrongCount,
      "no_ans_count": curState.sessionData.questionsCount -
          curState.sessionData.completeCount,
      "topic_id": curState.topic.dirName,
      "module_id": curState.module.dirName,
    });
  }
}
