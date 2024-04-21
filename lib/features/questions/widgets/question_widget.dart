import 'package:flutter/material.dart';
import 'package:testing_training/main.dart';
import 'package:testing_training/repositories/questions/models/question/question.dart';
import 'package:testing_training/repositories/session_save/models/models.dart';

import '../../../repositories/questions/models/module.dart';
import '../../../repositories/questions/models/topic.dart';
import 'one_select_question_widget.dart';

class QuestionWidget extends StatefulWidget {
  const QuestionWidget(
      {super.key,
      required this.question,
      required this.pageController,
      required this.isFirst,
      required this.isLast,
      required this.topic,
      required this.module,
      required this.sessionQuestion});

  final Topic topic;
  final Module module;
  final AbstractQuestion question;
  final SessionQuestion sessionQuestion;
  final PageController pageController;
  final bool isFirst;
  final bool isLast;

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Card(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: (widget.isFirst)
                        ? null
                        : () {
                            widget.pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut);
                          },
                    icon: const Icon(Icons.chevron_left)),
                IconButton(
                    onPressed: (widget.isLast)
                        ? null
                        : () {
                            widget.pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut);
                          },
                    icon: const Icon(Icons.chevron_right)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Divider(),
            ),
            if ((widget.question.getImage() != null))
              Padding(
                padding: const EdgeInsets.all(5),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(path(
                        'questions/${widget.topic.dirName}/images/${widget.question.getImage()}'))),
              ),
            Container(
                constraints: const BoxConstraints(maxWidth: 800),
                padding: const EdgeInsets.all(10),
                child: Text(
                  widget.question.getName(),
                  textAlign: TextAlign.center,
                )),
            _getQuestionAnswers(),
          ],
        ),
      ),
    );
  }

  Widget _getQuestionAnswers() {
    if (widget.question is OneSelectQuestion) {
      return OneSelectQuestionWidget(
          question: widget.question as OneSelectQuestion,
          sessionQuestion: widget.sessionQuestion,
          topic: widget.topic,
          module: widget.module);
    }

    return const CircularProgressIndicator();
  }
}
