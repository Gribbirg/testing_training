import 'package:flutter/material.dart';
import 'package:testing_training/repositories/questions/models/question/answer.dart';
import 'package:testing_training/repositories/session_save/models/models.dart';

import '../../../main.dart';
import '../../../repositories/questions/models/module.dart';
import '../../../repositories/questions/models/question/one_select_question.dart';
import '../../../repositories/questions/models/topic.dart';

class OneSelectQuestionWidget extends StatefulWidget {
  const OneSelectQuestionWidget(
      {super.key,
      required this.question,
      required this.topic,
      required this.module,
      required this.sessionQuestion});

  final OneSelectQuestion question;
  final SessionQuestion sessionQuestion;
  final Topic topic;
  final Module module;

  @override
  State<OneSelectQuestionWidget> createState() =>
      _OneSelectQuestionWidgetState();
}

class _OneSelectQuestionWidgetState extends State<OneSelectQuestionWidget> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widget.question.answers
            .map((answer) => Card(
                  shadowColor: (widget.sessionQuestion.userAnswer == answer)
                      ? null
                      : Colors.transparent,
                  elevation:
                      (widget.sessionQuestion.userAnswer == answer) ? 8 : null,
                  child: RadioListTile<Answer>(
                    title: Column(
                      children: [
                        if (answer.text != null) Text(answer.text!),
                        if (answer.image != null)
                          Image.asset(path(
                              'questions/${widget.topic.dirName}/images/${answer.image}')),
                      ],
                    ),
                    groupValue: widget.sessionQuestion.userAnswer,
                    onChanged: (newAnswer) {
                      setState(() {
                        widget.sessionQuestion.userAnswer = newAnswer;
                      });
                    },
                    value: answer,
                  ),
                ))
            .toList(),
      ),
    );
  }
}
