import 'package:flutter/material.dart';
import 'package:testing_training/repositories/session_save/models/models.dart';

import '../../../../repositories/questions/models/module.dart';
import '../../../../repositories/questions/models/question/string_question.dart';
import '../../../../repositories/questions/models/topic.dart';

class StringQuestionWidget extends StatefulWidget {
  const StringQuestionWidget({
    super.key,
    required this.question,
    required this.topic,
    required this.module,
    required this.sessionQuestion,
    required this.setParentState,
  });

  final StringQuestion question;
  final SessionQuestion sessionQuestion;
  final Topic topic;
  final Module module;
  final void Function(void Function()) setParentState;

  @override
  State<StringQuestionWidget> createState() => _StringQuestionWidgetState();
}

class _StringQuestionWidgetState extends State<StringQuestionWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = (widget.sessionQuestion.isRight == null)
        ? theme.colorScheme.outline
        : (widget.sessionQuestion.isRight!)
        ? theme.colorScheme.primary
        : theme.colorScheme.error;
    return IntrinsicWidth(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                focusNode: FocusNode(),
                enabled: widget.sessionQuestion.isRight == null,
                onChanged: (value) {
                  setState(() {
                    widget.setParentState(() {
                      widget.sessionQuestion.userAnswer =
                      (value.isEmpty) ? null : value;
                    });
                  });
                },
                initialValue: (widget.sessionQuestion.userAnswer == null ||
                    (widget.sessionQuestion.userAnswer as String).isEmpty)
                    ? null
                    : widget.sessionQuestion.userAnswer,
                style: TextStyle(color: theme.colorScheme.onSurface),
                decoration: InputDecoration(
                  constraints: const BoxConstraints(minWidth: 200, maxWidth: 500),
                  labelText: "Ответ",
                  labelStyle: TextStyle(
                    color: borderColor,
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: borderColor,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: borderColor,
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: borderColor,
                      )),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: borderColor,
                      )),
                  fillColor: (widget.sessionQuestion.isRight == null)
                      ? null
                      : (widget.sessionQuestion.isRight!)
                      ? theme.colorScheme.primary
                      : theme.colorScheme.error,
                ),
                onFieldSubmitted: (String? value) {
                  if (value != null && value.isNotEmpty) {
                    setState(() {
                      widget.setParentState(() {
                        widget.question.setAnswerRight(widget.sessionQuestion);
                      });
                    });
                  }
                },
              ),
            ),
            if (widget.sessionQuestion.isRight != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Правильный ответ: ${widget.question.answer}',
                  style: TextStyle(
                      color: (widget.sessionQuestion.isRight!)
                          ? theme.colorScheme.primary
                          : theme.colorScheme.error,
                      fontSize: 15),
                ),
              )
          ],
        ));
  }
}
