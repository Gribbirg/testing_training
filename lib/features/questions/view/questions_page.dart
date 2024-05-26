import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:testing_training/features/questions/bloc/questions_list_bloc.dart';
import 'package:testing_training/features/questions/questions.dart';
import 'package:testing_training/repositories/session_save/abstract_session_save_repository.dart';
import 'package:testing_training/router/router.dart';
import 'package:testing_training/widgets/app_bar.dart';
import 'package:testing_training/widgets/drawer.dart';

import '../../../repositories/questions/abstract_questions_repository.dart';
import '../../../widgets/adaptive_scaffold.dart';

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
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final _questionsListBloc = QuestionsListBloc(
    questionsRepository: GetIt.I<AbstractQuestionsRepository>(),
    sessionSaveRepository: GetIt.I<AbstractSessionSaveRepository>(),
  );

  PageController? pageController;

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
            pageController!.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut);
          } else if (event.physicalKey == PhysicalKeyboardKey.arrowRight) {
            pageController!.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut);
          }
        },
        child: BlocBuilder<QuestionsListBloc, QuestionsListState>(
          bloc: _questionsListBloc,
          builder: (BuildContext context, QuestionsListState state) {
            if (state is QuestionsListLoaded) {
              pageController = PageController(
                  initialPage: state.sessionData.currentQuestionNum);
              return AdaptiveScaffold(
                scaffoldKey: _key,
                drawer: _getDrawer(state),
                appBar: getAppBar(context, text: state.module.name),
                body: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 2.0,
                        horizontal: 8,
                      ),
                      child: SessionStateWidget(
                          rightCount: state.sessionData.rightsCount,
                          wrongCount: state.sessionData.wrongCount,
                          completeCount: state.sessionData.completeCount,
                          questionsCount: state.sessionData.questionsCount,
                          currentQuestionNum:
                              state.sessionData.currentQuestionNum),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PageView(
                          scrollDirection: Axis.horizontal,
                          controller: pageController,
                          onPageChanged: (i) {
                            setState(() {
                              state.sessionData.currentQuestionNum = i;
                            });
                          },
                          children: state.sessionData.sessionsQuestions
                              .map((sessionQuestion) {
                            final question =
                                state.questionsList[sessionQuestion.questionNum];
                            return QuestionWidget(
                              topic: state.topic,
                              module: state.module,
                              question: question,
                              sessionQuestion: sessionQuestion,
                              pageController: pageController!,
                              isFirst: state.questionsList[state.sessionData
                                      .sessionsQuestions.first.questionNum] ==
                                  question,
                              isLast: state.questionsList[state.sessionData
                                      .sessionsQuestions.last.questionNum] ==
                                  question,
                              onAnswer: (bool isRight) {
                                _questionsListBloc.add(SaveSessionData());
                                setState(() {
                                  state.sessionData.completeCount++;
                                  if (isRight) {
                                    state.sessionData.rightsCount++;
                                  } else {
                                    state.sessionData.wrongCount++;
                                  }
                                });
                              },
                              scrollToNextOpenedQuestion: () {
                                if (!state.sessionData.allQuestionsAreClosed()) {
                                  final sessionsQuestions =
                                      state.sessionData.sessionsQuestions;
                                  int page = pageController!.page!.toInt();

                                  while (page < sessionsQuestions.length &&
                                      sessionsQuestions[page].isRight != null) {
                                    page++;
                                  }

                                  if (page == sessionsQuestions.length) {
                                    page =
                                        state.sessionData.getFirstOpenedIndex();
                                  }

                                  pageController?.animateToPage(page,
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut);
                                } else {
                                  _questionsListBloc.add(QuestionsFinishEvent());
                                }
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
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

            if (state is QuestionsFinishState) {
              return AdaptiveScaffold(
                  scaffoldKey: _key,
                  drawer: _getDrawer(state),
                  appBar: getAppBar(context, text: state.module.name),
                  body: QuestionFinishedPage(
                    state: state,
                    restart: () {
                      _questionsListBloc
                          .add(RestartSession(sessionData: state.sessionData));
                    },
                    toModules: () {
                      _questionsListBloc.add(DeleteSessionData());
                      AutoRouter.of(context).push(
                          ModuleSelectRoute(topicId: state.topic.dirName));
                    },
                    toTopics: () {
                      _questionsListBloc.add(DeleteSessionData());
                      AutoRouter.of(context).push(const HomeRoute());
                    },
                  ));
            }

            return AdaptiveScaffold(
              scaffoldKey: _key,
              drawer: BaseDrawer(
                scaffoldKey: _key,
              ),
              appBar: getAppBar(context, text: 'Загрузка...'),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ));
  }

  Widget _getDrawer(QuestionsListState state) {
    assert(state is QuestionsListLoaded || state is QuestionsFinishState);
    final sessionData = (state is QuestionsListLoaded)
        ? state.sessionData
        : state is QuestionsFinishState
            ? state.sessionData
            : null;
    return BaseDrawer(
      scaffoldKey: _key,
      body: [
        getBaseDrawerListTile(
            context: context,
            icon: const Icon(Icons.refresh_sharp),
            title: const Text('Заново'),
            onTap: () {
              _questionsListBloc.add(RestartSession(sessionData: sessionData!));
              pageController!.jumpToPage(0);
              _key.currentState!.closeDrawer();
            }),
        getBaseDrawerListTile(
            context: context,
            icon: const Icon(Icons.topic_rounded),
            title: const Text('К темам'),
            onTap: () {
              _key.currentState!.closeDrawer();
              AutoRouter.of(context)
                  .push(ModuleSelectRoute(topicId: widget.topicId));
            }),
        const Divider(),
        getBaseDrawerListTile(
          context: context,
          icon: const Icon(Icons.question_mark_rounded),
          title: const Text('Вопросы'),
          onTap: null,
        ),
        Flexible(
          fit: FlexFit.loose,
          child: QuestionsNavigationGridWidget(
            pageController: pageController,
            sessionData: sessionData!,
            scaffoldKey: _key,
          ),
        ),
      ],
    );
  }
}
