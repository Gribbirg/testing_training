import 'package:flutter/material.dart';
import 'package:testing_training/repositories/session_save/models/models.dart';

import '../../../repositories/questions/models/module.dart';
import '../../../repositories/questions/models/question/multi_select_question.dart';
import '../../../repositories/questions/models/topic.dart';
import '../../../widgets/cloud_image_widget.dart';

class MultiSelectQuestionWidget extends StatefulWidget {
  const MultiSelectQuestionWidget({
    super.key,
    required this.question,
    required this.topic,
    required this.module,
    required this.sessionQuestion,
    required this.setParentState,
  });

  final MultiSelectQuestion question;
  final SessionQuestion sessionQuestion;
  final Topic topic;
  final Module module;
  final void Function(void Function()) setParentState;

  @override
  State<MultiSelectQuestionWidget> createState() =>
      _MultiSelectQuestionWidgetState();
}

class _MultiSelectQuestionWidgetState extends State<MultiSelectQuestionWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: (widget.sessionQuestion.saveAnswersNum as List<int>)
            .map((answerNum) {
          final answer = widget.question.answers[answerNum];
          final isRightAnswer = (widget.sessionQuestion.isRight != null)
              ? widget.question.rightAnswersNumbers.contains(answer.number)
              : false;
          final isUserAnswer = widget.sessionQuestion.userAnswer[answerNum];
          final isResult = widget.sessionQuestion.isRight != null;
          return Card(
            shadowColor:
                (isUserAnswer || isRightAnswer) ? null : Colors.transparent,
            elevation: (isUserAnswer || isRightAnswer) ? 5 : null,
            color: (isResult && !isRightAnswer && isUserAnswer)
                ? theme.colorScheme.errorContainer
                : (isRightAnswer)
                    ? (isUserAnswer)
                        ? theme.colorScheme.primaryContainer
                        : theme.colorScheme.secondaryContainer
                    : theme.cardColor,
            child: CheckboxListTile(
              activeColor: (isResult && !isRightAnswer && isUserAnswer)
                  ? theme.colorScheme.error
                  : (isRightAnswer)
                      ? (isUserAnswer)
                          ? theme.colorScheme.onPrimaryContainer
                          : theme.colorScheme.onSecondaryContainer
                      : null,
              title: Column(
                children: [
                  if (answer.text != null)
                    Text(
                      answer.text!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: (isResult && !isRightAnswer && isUserAnswer)
                              ? theme.colorScheme.onErrorContainer
                              : null),
                    ),
                  if (answer.image != null)
                    CloudImageWidget(
                      topicDir: widget.topic.dirName,
                      imageName: widget.question.getImage()!,
                    ),
                ],
              ),
              onChanged: (!isResult)
                  ? (newAnswer) {
                      setState(() {
                        widget.setParentState(() {
                          widget.sessionQuestion.userAnswer[answerNum] =
                              newAnswer;
                        });
                      });
                    }
                  : (isRightAnswer || isUserAnswer)
                      ? (_) {}
                      : null,
              value: isUserAnswer,
            ),
          );
        }).toList(),
      ),
    );
  }
}
