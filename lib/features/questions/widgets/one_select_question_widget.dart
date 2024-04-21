import 'package:flutter/material.dart';
import 'package:testing_training/repositories/questions/models/question/answer.dart';

import '../../../main.dart';
import '../../../repositories/questions/models/module.dart';
import '../../../repositories/questions/models/question/one_select_question.dart';
import '../../../repositories/questions/models/topic.dart';

class OneSelectQuestionWidget extends StatefulWidget {
  const OneSelectQuestionWidget(
      {super.key,
      required this.question,
      required this.topic,
      required this.module});

  final OneSelectQuestion question;
  final Topic topic;
  final Module module;

  @override
  State<OneSelectQuestionWidget> createState() =>
      _OneSelectQuestionWidgetState();
}

class _OneSelectQuestionWidgetState extends State<OneSelectQuestionWidget> {
  Answer? _selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widget.question.answers
            .map((answer) => Card(
                  elevation: (_selectedAnswer == answer)? 8 : null,
                  child: RadioListTile<Answer>(
                    title: Column(
                      children: [
                        (answer.text != null)
                            ? Text(answer.text!)
                            : const SizedBox(),
                        (answer.image != null)
                            ? Image.asset(path(
                                'questions/${widget.topic.dirName}/images/${answer.image}'))
                            : const SizedBox(),
                      ],
                    ),
                    groupValue: _selectedAnswer,
                    onChanged: (newAnswer) {
                      setState(() {
                        _selectedAnswer = newAnswer;
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
