import 'package:flutter/material.dart';
import 'package:testing_training/repositories/session_save/models/models.dart';

import '../../../../repositories/questions/models/module.dart';
import '../../../../repositories/questions/models/question/categories_question.dart';
import '../../../../repositories/questions/models/topic.dart';
import '../../../../widgets/cloud_image_widget.dart';

class CategoriesQuestionWidget extends StatefulWidget {
  const CategoriesQuestionWidget({
    super.key,
    required this.question,
    required this.topic,
    required this.module,
    required this.sessionQuestion,
    required this.setParentState,
  });

  final CategoriesQuestion question;
  final SessionQuestion sessionQuestion;
  final Topic topic;
  final Module module;
  final void Function(void Function()) setParentState;

  @override
  State<CategoriesQuestionWidget> createState() =>
      _CategoriesQuestionWidgetState();
}

class _CategoriesQuestionWidgetState extends State<CategoriesQuestionWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final order =
        (widget.sessionQuestion.saveAnswersNum as List).cast<List<int>>();
    final userAnswer = (widget.sessionQuestion.userAnswer as List).cast<int?>();
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Divider(),
          const Text("Ответы:"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: order[1].asMap().entries.map((entry) {
                final index = entry.key;
                final answer = widget.question.answers[entry.value];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText('${_getLetter(index)}. ${answer.text ?? ""}'),
                    if (answer.image != null)
                      CloudImageWidget(
                        topicDir: widget.topic.dirName,
                        imageName: answer.image!,
                        isFullScreen: true,
                      ),
                  ],
                );
              }).toList(),
            ),
          ),
          const Divider(),
          Column(
            children: order[0].map((statementNum) {
              final statement = widget.question.statements[statementNum];
              final borderColor = (widget.sessionQuestion.isRight == null)
                  ? theme.colorScheme.outline
                  : (userAnswer[statementNum] ==
                          widget.question.rightAnswersNumbers[statementNum])
                      ? theme.colorScheme.primary
                      : theme.colorScheme.error;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            if (statement.text != null)
                            Text(statement.text!),
                            if (statement.image != null)
                              CloudImageWidget(
                                topicDir: widget.topic.dirName,
                                imageName: statement.image!,
                              ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 150),
                      child: DropdownButtonFormField<int>(
                        focusNode: FocusNode(),
                        focusColor: Colors.transparent,
                        value: (userAnswer[statementNum] != null)
                            ? order[1].indexOf(userAnswer[statementNum]!)
                            : null,
                        items: [
                          for (int i = 0; i < widget.question.answersCount; i++)
                            DropdownMenuItem(
                              value: i,
                              child: Text(
                                _getLetter(i),
                                style: TextStyle(
                                    color: theme.colorScheme.onSurface),
                              ),
                            )
                        ],
                        onChanged: (widget.sessionQuestion.isRight == null)
                            ? (int? value) {
                                userAnswer[statementNum] = value;
                                setState(() {
                                  widget.setParentState(() {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    userAnswer[statementNum] = (value != null)
                                        ? order[1][value]
                                        : null;
                                  });
                                });
                              }
                            : null,
                        elevation: 0,
                        isExpanded: true,
                        decoration: InputDecoration(
                          enabled: true,
                          constraints: const BoxConstraints(
                              minWidth: 200, maxWidth: 500),
                          labelText: "Ответ",
                          suffixText: (widget.sessionQuestion.isRight != null)
                              ? _getLetter(order[1].indexOf(widget
                                  .question.rightAnswersNumbers[statementNum]))
                              : null,
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
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  String _getLetter(int ascii) => String.fromCharCode(65 + ascii);
}
