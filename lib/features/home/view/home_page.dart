import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_training/features/home/bloc/topic_list_bloc.dart';
import 'package:testing_training/features/home/widgets/topic_item.dart';
import 'package:testing_training/main.dart';
import 'package:testing_training/repositories/topic_list/abstract_topic_list_repository.dart';
import 'package:get_it/get_it.dart';

import '../../../router/router.dart';

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
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        shape: Border(
            bottom:
                BorderSide(color: theme.colorScheme.outlineVariant, width: 1)),
        leading: Image.asset(path('images/logo.png')),
        title: Text(
          "Подготовка к ЦТ",
          style: TextStyle(color: theme.colorScheme.onBackground),
        ),
        backgroundColor: theme.colorScheme.background,
        elevation: 10,
        actions: [
          IconButton(
              onPressed: () {
                AutoRouter.of(context).push(const HomeRoute());
              },
              icon: const Icon(Icons.home))
        ],
      ),
      body: Column(children: [
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Выберите предмет:",
          style: TextStyle(fontSize: 20),
        ),
        Expanded(
          flex: 1,
          child: BlocBuilder<TopicListBloc, TopicListState>(
            bloc: _topicListBloc,
            builder: (BuildContext context, TopicListState state) {
              if (state is TopicListLoaded) {
                final topicList = state.topicList;
                return ListView.builder(
                  padding: const EdgeInsets.all(4),
                  itemCount: topicList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Align(
                      alignment: Alignment.center,
                      child: Container(
                        constraints: const BoxConstraints(
                            maxWidth: 500
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: TopicItem(
                          topic: topicList[index],
                        ),
                      ),
                    );
                  },
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
        ),
      ]),
    );
  }
}
