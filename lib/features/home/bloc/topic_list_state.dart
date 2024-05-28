part of 'topic_list_bloc.dart';

abstract class TopicListState extends Equatable {}

class TopicListInitial extends TopicListState {
  @override
  List<Object?> get props => [];
}

class TopicListLoading extends TopicListState {
  @override
  List<Object?> get props => [];
}

class TopicListLoaded extends TopicListState {
  final List<Topic> topicList;

  TopicListLoaded({required this.topicList});

  @override
  List<Object?> get props => [topicList];
}

class TopicListError extends TopicListState {

  final dynamic exception;

  TopicListError({required this.exception});

  @override
  List<Object?> get props => [exception];
}
