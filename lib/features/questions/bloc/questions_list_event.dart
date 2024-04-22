part of 'questions_list_bloc.dart';

abstract class QuestionsListEvent extends Equatable {}

class LoadQuestionsList extends QuestionsListEvent {

  final String? topicId;

  final String? moduleId;

  LoadQuestionsList({required this.topicId, required this.moduleId});

  @override
  List<Object?> get props => [topicId, moduleId];
}

class SaveSessionData extends QuestionsListEvent {
  @override
  List<Object?> get props => [];
}


class DeleteSessionData extends QuestionsListEvent {
  @override
  List<Object?> get props => [];
}

class RestartSession extends QuestionsListEvent {
  @override
  List<Object?> get props => [];
}