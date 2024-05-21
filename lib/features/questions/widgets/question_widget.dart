import 'package:flutter/material.dart';
import 'package:testing_training/features/questions/widgets/categories_question_widget.dart';
import 'package:testing_training/features/questions/widgets/multi_select_question_widget.dart';
import 'package:testing_training/features/questions/widgets/num_question_widget.dart';
import 'package:testing_training/features/questions/widgets/string_question_widget.dart';
import 'package:testing_training/repositories/questions/models/question/categories_question.dart';
import 'package:testing_training/repositories/questions/models/question/question.dart';
import 'package:testing_training/repositories/session_save/models/models.dart';
import 'package:testing_training/widgets/cloud_image_widget.dart';

import '../../../repositories/questions/models/module.dart';
import '../../../repositories/questions/models/topic.dart';
import 'one_select_question_widget.dart';
import 'order_question_widget.dart';

class QuestionWidget extends StatefulWidget {
  const QuestionWidget(
      {super.key,
      required this.question,
      required this.pageController,
      required this.isFirst,
      required this.isLast,
      required this.topic,
      required this.module,
      required this.sessionQuestion,
      required this.onAnswer,
      required this.scrollToNextOpenedQuestion});

  final Topic topic;
  final Module module;
  final AbstractQuestion question;
  final SessionQuestion sessionQuestion;
  final PageController pageController;
  final bool isFirst;
  final bool isLast;
  final void Function() onAnswer;
  final void Function() scrollToNextOpenedQuestion;

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  Expanded(
                    child: Text(
                      (widget.sessionQuestion.isRight == null)
                          ? "Ответьте на вопрос:"
                          : (widget.sessionQuestion.isRight!)
                              ? "Правильно!"
                              : "Неправильно!",
                      style: TextStyle(
                        color: (widget.sessionQuestion.isRight == null)
                            ? null
                            : (widget.sessionQuestion.isRight!)
                                ? theme.colorScheme.primary
                                : theme.colorScheme.error,
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
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
            ),
            if ((widget.question.getImage() != null))
              Padding(
                padding: const EdgeInsets.all(8),
                child: CloudImageWidget(
                  topicDir: widget.topic.dirName,
                  imageName: widget.question.getImage()!,
                ),
              ),
            Container(
                constraints: const BoxConstraints(maxWidth: 800),
                padding: const EdgeInsets.all(10),
                child: SelectableText(
                  widget.question.getName(),
                  textAlign: TextAlign.center,
                )),
            _getQuestionAnswers(),
            Container(
                constraints:
                    const BoxConstraints(minWidth: 200, minHeight: 100),
                padding: const EdgeInsets.all(20),
                child: (widget.sessionQuestion.isRight == null)
                    ? FilledButton(
                        onPressed: (widget.question.isAnswerFilled(
                                widget.sessionQuestion.userAnswer))
                            ? () {
                                setState(() {
                                  widget.question
                                      .setAnswerRight(widget.sessionQuestion);
                                  widget.onAnswer();
                                });
                              }
                            : null,
                        child: const Text("Ответить"),
                      )
                    : OutlinedButton(
                        onPressed: widget.scrollToNextOpenedQuestion,
                        child: Text(
                          "Следующий",
                          style: TextStyle(
                            color: (widget.sessionQuestion.isRight == null)
                                ? null
                                : (widget.sessionQuestion.isRight!)
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.error,
                          ),
                        ),
                      )),
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
        module: widget.module,
        setParentState: setState,
      );
    }

    if (widget.question is NumQuestion) {
      return NumQuestionWidget(
        question: widget.question as NumQuestion,
        sessionQuestion: widget.sessionQuestion,
        topic: widget.topic,
        module: widget.module,
        setParentState: setState,
      );
    }

    if (widget.question is StringQuestion) {
      return StringQuestionWidget(
        question: widget.question as StringQuestion,
        sessionQuestion: widget.sessionQuestion,
        topic: widget.topic,
        module: widget.module,
        setParentState: setState,
      );
    }

    if (widget.question is MultiSelectQuestion) {
      return MultiSelectQuestionWidget(
        question: widget.question as MultiSelectQuestion,
        sessionQuestion: widget.sessionQuestion,
        topic: widget.topic,
        module: widget.module,
        setParentState: setState,
      );
    }

    if (widget.question is CategoriesQuestion) {
      return CategoriesQuestionWidget(
        question: widget.question as CategoriesQuestion,
        sessionQuestion: widget.sessionQuestion,
        topic: widget.topic,
        module: widget.module,
        setParentState: setState,
      );
    }

    if (widget.question is OrderQuestion) {
      return OrderQuestionWidget(
        question: widget.question as OrderQuestion,
        sessionQuestion: widget.sessionQuestion,
        topic: widget.topic,
        module: widget.module,
        setParentState: setState,
      );
    }

    return const CircularProgressIndicator();
  }
}
