part of 'questions_list_bloc.dart';

abstract class QuestionsListState extends Equatable {}

class QuestionsListInitial extends QuestionsListState {
  @override
  List<Object?> get props => [];
}

class QuestionsListLoading extends QuestionsListState {
  @override
  List<Object?> get props => [];
}

class QuestionsListLoaded extends QuestionsListState {
  final List<AbstractQuestion> questionsList;

  final List<SessionQuestion> sessionQuestions;

  QuestionsListLoaded(
      {required this.questionsList, required this.sessionQuestions});

  @override
  List<Object?> get props => [questionsList, sessionQuestions];
}

class QuestionsListError extends QuestionsListState {
  final String message;

  QuestionsListError({required this.message});

  @override
  List<Object?> get props => [message];
}
