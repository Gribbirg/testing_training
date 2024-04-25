import 'package:flutter/material.dart';
import 'package:testing_training/repositories/questions/models/question/answer.dart';
import 'package:testing_training/repositories/session_save/models/models.dart';

import '../../../main.dart';
import '../../../repositories/questions/models/module.dart';
import '../../../repositories/questions/models/question/one_select_question.dart';
import '../../../repositories/questions/models/topic.dart';

class OneSelectQuestionWidget extends StatefulWidget {
  const OneSelectQuestionWidget({
    super.key,
    required this.question,
    required this.topic,
    required this.module,
    required this.sessionQuestion,
    required this.setParentState,
  });

  final OneSelectQuestion question;
  final SessionQuestion sessionQuestion;
  final Topic topic;
  final Module module;
  final void Function(void Function()) setParentState;

  @override
  State<OneSelectQuestionWidget> createState() =>
      _OneSelectQuestionWidgetState();
}

class _OneSelectQuestionWidgetState extends State<OneSelectQuestionWidget> {
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
              ? widget.question.rightAnswerNumber == answer.number
              : false;
          final isUserAnswer =
              widget.sessionQuestion.userAnswer == answer.number;
          final isResult = widget.sessionQuestion.isRight != null;
          return Card(
            shadowColor:
                (isUserAnswer || isRightAnswer) ? null : Colors.transparent,
            elevation: (isUserAnswer || isRightAnswer) ? 5 : null,
            color: (isResult && !isRightAnswer && isUserAnswer)
                ? theme.colorScheme.errorContainer
                : (isRightAnswer)
                    ? theme.colorScheme.primaryContainer
                    : theme.cardColor,
            child: RadioListTile<Answer>(
              activeColor: (isResult && !isRightAnswer && isUserAnswer)
                  ? theme.colorScheme.error
                  : (isRightAnswer)
                      ? theme.colorScheme.onPrimaryContainer
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
                    Image.asset(path(
                        'questions/${widget.topic.dirName}/images/${answer.image}')),
                ],
              ),
              groupValue: (widget.sessionQuestion.userAnswer == null)
                  ? widget.sessionQuestion.userAnswer
                  : widget.question.answers[widget.sessionQuestion.userAnswer],
              onChanged: (!isResult)
                  ? (newAnswer) {
                      setState(() {
                        widget.setParentState(() {
                          widget.sessionQuestion.userAnswer = newAnswer!.number;
                        });
                      });
                    }
                  : (isRightAnswer || isUserAnswer)
                      ? (_) {}
                      : null,
              value: answer,
            ),
          );
        }).toList(),
      ),
    );
  }
}
