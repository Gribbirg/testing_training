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

  QuestionsListLoaded({required this.questionsList});

  @override
  List<Object?> get props => [questionsList];
}

class QuestionsListError extends QuestionsListState {

  final String message;

  QuestionsListError({required this.message});

  @override
  List<Object?> get props => [message];
}