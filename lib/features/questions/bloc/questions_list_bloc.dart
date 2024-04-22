import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_training/repositories/questions/models/models.dart';

import '../../../repositories/questions/abstract_questions_repository.dart';
import '../../../repositories/questions/models/question/abstract_question.dart';
import '../../../repositories/session_save/models/session_question.dart';

part 'questions_list_event.dart';

part 'questions_list_state.dart';

class QuestionsListBloc extends Bloc<QuestionsListEvent, QuestionsListState> {
  QuestionsListBloc(this.questionsRepository) : super(QuestionsListInitial()) {
    on<LoadQuestionsList>(_load);
  }

  final AbstractQuestionsRepository questionsRepository;

  Future<void> _load(
      LoadQuestionsList event, Emitter<QuestionsListState> emit) async {
    try {
      if (state is! QuestionsListLoaded) {
        emit(QuestionsListLoading());
      }
      final questionsList =
          await questionsRepository.getQuestionsList(event.topic, event.module);
      if (questionsList == null || questionsList.isEmpty) {
        emit(QuestionsListError(message: "Вопросы не найдены"));
      } else {
        emit(QuestionsListLoaded(
          questionsList: questionsList,
          sessionQuestions: _getShuffledQuestions(questionsList),
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
}
