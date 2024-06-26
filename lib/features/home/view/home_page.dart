import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_training/features/home/bloc/topic_list_bloc.dart';
import 'package:testing_training/features/home/widgets/topic_item.dart';
import 'package:testing_training/repositories/questions/abstract_questions_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:testing_training/widgets/adaptive_scaffold.dart';
import 'package:testing_training/widgets/error_widget.dart';

import '../../../widgets/drawer.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final _topicListBloc = TopicListBloc(GetIt.I<AbstractQuestionsRepository>());

  @override
  void initState() {
    _topicListBloc.add(LoadTopicList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    return AdaptiveScaffold(
      scaffoldKey: _key,
      appBarTitle: "Подготовка к ЦТ",
      drawer: BaseDrawer(
        scaffoldKey: _key,
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
                        constraints: const BoxConstraints(maxWidth: 500),
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
                return ErrorAppWidget(
                  exception: state.exception,
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
