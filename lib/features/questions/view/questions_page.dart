import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:testing_training/features/questions/bloc/questions_list_bloc.dart';
import 'package:testing_training/features/questions/widgets/question_widget.dart';
import 'package:testing_training/repositories/session_save/abstract_session_save_repository.dart';
import 'package:testing_training/router/router.dart';

import '../../../repositories/questions/abstract_questions_repository.dart';

@RoutePage()
class QuestionsPage extends StatefulWidget {
  const QuestionsPage(
      {super.key,
      @PathParam("topic") required this.topicId,
      @PathParam("module") required this.moduleId});

  final String? topicId;
  final String? moduleId;

  @override
  State<StatefulWidget> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  final _questionsListBloc = QuestionsListBloc(
      questionsRepository: GetIt.I<AbstractQuestionsRepository>(),
      sessionSaveRepository: GetIt.I<AbstractSessionSaveRepository>());
  final PageController pageController = PageController();

  @override
  void initState() {
    if (widget.topicId == null || widget.moduleId == null) {
      AutoRouter.of(context).popAndPush(const HomeRoute());
    } else {
      _questionsListBloc.add(LoadQuestionsList(
          topicId: widget.topicId, moduleId: widget.moduleId));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKeyEvent: (event) {
          if (event.physicalKey == PhysicalKeyboardKey.arrowLeft) {
            pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut);
          } else if (event.physicalKey == PhysicalKeyboardKey.arrowRight) {
            pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut);
          }
        },
        child: BlocBuilder<QuestionsListBloc, QuestionsListState>(
          bloc: _questionsListBloc,
          builder: (BuildContext context, QuestionsListState state) {
            if (state is QuestionsListLoaded) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(state.module.name),
                ),
                body: PageView(
                  scrollDirection: Axis.horizontal,
                  controller: pageController,
                  children: state.sessionData.sessionsQuestions
                      .map((sessionQuestion) {
                    final question =
                        state.questionsList[sessionQuestion.questionNum];
                    return QuestionWidget(
                      topic: state.topic,
                      module: state.module,
                      question: question,
                      sessionQuestion: sessionQuestion,
                      pageController: pageController,
                      isFirst: state.questionsList[state.sessionData
                              .sessionsQuestions.first.questionNum] ==
                          question,
                      isLast: state.questionsList[state.sessionData
                              .sessionsQuestions.last.questionNum] ==
                          question,
                      onAnswer: () {
                        _questionsListBloc.add(SaveSessionData());
                      },
                      scrollToNextOpenedQuestion: () {
                        if (state.sessionData.sessionsQuestions
                            .any((element) => element.isRight == null)) {
                          final sessionsQuestions =
                              state.sessionData.sessionsQuestions;
                          int page = pageController.page!.toInt();

                          while (page < sessionsQuestions.length &&
                              sessionsQuestions[page].isRight != null) {
                            page++;
                          }

                          if (page == sessionsQuestions.length) {
                            page = sessionsQuestions.indexWhere(
                                (element) => element.isRight == null);
                          }

                          pageController.animateToPage(page,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        } else {
                          _questionsListBloc.add(DeleteSessionData());
                          AutoRouter.of(context).popAndPush(const HomeRoute());
                        }
                      },
                    );
                  }).toList(),
                ),
              );
            }

            if (state is QuestionsListError) {
              return Center(
                child: Text(
                  state.message,
                ),
              );
            }

            return Scaffold(
              appBar: AppBar(
                title: const Text("Загрузка..."),
              ),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ));
  }
}
