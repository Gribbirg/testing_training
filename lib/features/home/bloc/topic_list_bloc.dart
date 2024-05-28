import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:testing_training/repositories/questions/abstract_questions_repository.dart';

import '../../../repositories/questions/models/topic.dart';
import '../../../services/error_handler/abstract_error_handler.dart';

part 'topic_list_state.dart';

part 'topic_list_event.dart';

class TopicListBloc extends Bloc<TopicListEvent, TopicListState> {
  TopicListBloc(this.questionsRepository) : super(TopicListInitial()) {
    on<LoadTopicList>(_load);
  }

  final AbstractQuestionsRepository questionsRepository;

  Future<void> _load(LoadTopicList event, Emitter<TopicListState> emit) async {
    try {
      if (state is! TopicListLoaded) {
        emit(TopicListLoading());
      }
      final topicList = await questionsRepository.getTopicList();
      if (topicList == null || topicList.isEmpty) {
        emit(TopicListError(exception: "Темы не найдены"));
      } else {
        emit(TopicListLoaded(topicList: topicList));
      }
    } catch (e, s) {
      GetIt.I<AbstractErrorHandler>().handleError(exception: e, stack: s);
      emit(TopicListError(exception: e));
    }
  }
}
