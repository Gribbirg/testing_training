import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_training/repositories/questions/abstract_questions_repository.dart';
import 'package:testing_training/repositories/questions_cache/abstract_questions_cache_repository.dart';

import '../../../repositories/questions/models/topic.dart';

part 'topic_list_state.dart';

part 'topic_list_event.dart';

class TopicListBloc extends Bloc<TopicListEvent, TopicListState> {
  TopicListBloc(this.questionsRepository, this.questionsCacheRepository)
      : super(TopicListInitial()) {
    on<LoadTopicList>(_load);
  }

  final AbstractQuestionsRepository questionsRepository;
  final AbstractQuestionsCacheRepository questionsCacheRepository;

  Future<void> _load(LoadTopicList event, Emitter<TopicListState> emit) async {
    try {
      if (state is! TopicListLoaded) {
        emit(TopicListLoading());
      }
      List<Topic>? topicList;
      if (await questionsCacheRepository.hasTopicsData()) {
        topicList = await questionsCacheRepository.getTopicsData();
      } else {
        topicList = await questionsRepository.getTopicList();
        if (topicList != null) {
          questionsCacheRepository.saveTopicsData(topicList);
        }
      }
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
