import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:testing_training/features/questions/bloc/questions_list_bloc.dart';
import 'package:testing_training/features/questions/widgets/question_widget.dart';
import 'package:testing_training/router/router.dart';

import '../../../repositories/questions/abstract_questions_repository.dart';
import '../../../repositories/questions/models/module.dart';
import '../../../repositories/questions/models/topic.dart';

@RoutePage()
class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key, this.topic, this.module});

  final Topic? topic;
  final Module? module;

  @override
  State<StatefulWidget> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  late final Topic _topic;
  late final Module _module;
  final _questionsListBloc =
      QuestionsListBloc(GetIt.I<AbstractQuestionsRepository>());
  final PageController pageController = PageController();

  @override
  void initState() {
    if (widget.topic == null || widget.module == null) {
      AutoRouter.of(context).popAndPush(const HomeRoute());
    } else {
      _topic = widget.topic!;
      _module = widget.module!;
      _questionsListBloc.add(LoadQuestionsList(topic: _topic, module: _module));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_module.name),
        ),
        body: BlocBuilder<QuestionsListBloc, QuestionsListState>(
          bloc: _questionsListBloc,
          builder: (BuildContext context, QuestionsListState state) {
            if (state is QuestionsListLoaded) {
              return PageView(
                scrollDirection: Axis.horizontal,
                controller: pageController,
                children: state.questionsList
                    .map((question) => QuestionWidget(
                          question: question,
                          pageController: pageController,
                          isFirst: state.questionsList.first == question,
                          isLast: state.questionsList.last == question,
                        ))
                    .toList(),
              );
            }

            if (state is QuestionsListError) {
              return Center(
                child: Text(
                  state.message,
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
