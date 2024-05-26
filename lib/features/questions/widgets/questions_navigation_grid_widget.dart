import 'package:flutter/material.dart';
import 'package:testing_training/repositories/session_save/models/models.dart';

class QuestionsNavigationGridWidget extends StatefulWidget {
  const QuestionsNavigationGridWidget(
      {super.key,
      required this.pageController,
      required this.sessionData,
      required this.scaffoldKey});

  final GlobalKey<ScaffoldState> scaffoldKey;
  final PageController? pageController;
  final SessionData sessionData;

  @override
  State<QuestionsNavigationGridWidget> createState() =>
      _QuestionsNavigationGridWidgetState();
}

class _QuestionsNavigationGridWidgetState
    extends State<QuestionsNavigationGridWidget> {
  final int crossAxisCount = 6;
  final double blockWidth = 250.0;
  final double blockHeight = 250.0;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: crossAxisCount,
      physics: const NeverScrollableScrollPhysics(),
      children: widget.sessionData.sessionsQuestions.asMap().entries.map(
        (entry) {
          final sessionQuestion = entry.value;
          final isCurrent = entry.key == widget.sessionData.currentQuestionNum;
          return Center(
            child: Padding(
              padding: EdgeInsets.all(isCurrent ? 2 : 4),
              child: SizedBox(
                width: blockWidth,
                height: blockHeight,
                child: FilledButton(
                  onPressed: () {
                    widget.scaffoldKey.currentState!.closeDrawer();
                    widget.pageController?.animateToPage(entry.key,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(8)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                      backgroundColor: MaterialStateProperty.all(isCurrent
                          ? Theme.of(context).colorScheme.tertiaryContainer
                          : sessionQuestion.isRight == null
                              ? Theme.of(context).colorScheme.surface
                              : sessionQuestion.isRight!
                                  ? Theme.of(context)
                                      .colorScheme
                                      .primaryContainer
                                  : Theme.of(context)
                                      .colorScheme
                                      .errorContainer),
                      elevation: MaterialStateProperty.all(isCurrent ? 8 : 2)),
                  child: Text(
                    (entry.key + 1).toString(),
                    style: TextStyle(
                        color: sessionQuestion.isRight == null
                            ? Theme.of(context).colorScheme.onSurface
                            : sessionQuestion.isRight!
                                ? Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer
                                : Theme.of(context)
                                    .colorScheme
                                    .onErrorContainer),
                  ),
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
