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
  final Topic topic;

  final Module module;

  final List<AbstractQuestion> questionsList;

  final SessionData sessionData;

  QuestionsListLoaded(
      {required this.topic,
      required this.module,
      required this.questionsList,
      required this.sessionData});

  @override
  List<Object?> get props => [topic, module, questionsList, sessionData];
}

class QuestionsListError extends QuestionsListState {
  final String message;

  QuestionsListError({required this.message});

  @override
  List<Object?> get props => [message];
}

class QuestionsListNotFound extends QuestionsListState {
  @override
  List<Object?> get props => [];
}

class QuestionsFinishState extends QuestionsListState {
  final SessionData sessionData;
  final Module module;
  final Topic topic;

  QuestionsFinishState({
    required this.module,
    required this.topic,
    required this.sessionData
  });

  @override
  List<Object?> get props => [topic, module, sessionData];
}
