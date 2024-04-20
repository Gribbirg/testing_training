part of 'questions_list_bloc.dart';

abstract class QuestionsListEvent extends Equatable {}

class LoadQuestionsList extends QuestionsListEvent {

  final Topic topic;

  final Module module;

  LoadQuestionsList({required this.topic, required this.module});

  @override
  List<Object?> get props => [topic, module];
}