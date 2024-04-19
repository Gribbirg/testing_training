import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_training/features/home/bloc/topic_list_bloc.dart';
import 'package:testing_training/features/home/widgets/topic_item.dart';
import 'package:testing_training/repositories/topic_list/abstract_topic_list_repository.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _topicListBloc = TopicListBloc(GetIt.I<AbstractTopicListRepository>());

  @override
  void initState() {
    _topicListBloc.add(LoadTopicList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<TopicListBloc, TopicListState>(
        bloc: _topicListBloc,
        builder: (BuildContext context, TopicListState state) {
          if (state is TopicListLoaded) {
            final topicList = state.topicList;
            return Center(
                child: ListView.builder(
                  itemCount: topicList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TopicItem(topic: topicList[index],);
                  },
                )
            );
          }

          if (state is TopicListError) {
            final message = state.message;
            return Center(
              child: Text(message),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
