import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/topic_list/abstract_topic_list_repository.dart';
import '../../../repositories/topic_list/models/topic.dart';

part 'topic_list_state.dart';

part 'topic_list_event.dart';

class TopicListBloc extends Bloc<TopicListEvent, TopicListState> {
  TopicListBloc(this.topicListRepository) : super(TopicListInitial()) {
    on<LoadTopicList>(_load);
  }

  final AbstractTopicListRepository topicListRepository;

  Future<void> _load(LoadTopicList event, Emitter<TopicListState> emit) async {
    try {
      if (state is! TopicListLoaded) {
        emit(TopicListLoading());
      }
      final topicList = await topicListRepository.getTopicList();
      if (topicList == null || topicList.isEmpty) {
        emit(TopicListError(message: "Темы не найдены"));
      } else {
        emit(TopicListLoaded(topicList: topicList));
      }
    } catch (e) {
      emit(TopicListError(message: e.toString()));
    }
  }
}
