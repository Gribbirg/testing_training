import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:testing_training/repositories/session_save/models/models.dart';

import '../../../repositories/questions/models/module.dart';
import '../../../repositories/questions/models/question/order_question.dart';
import '../../../repositories/questions/models/topic.dart';
import '../../../widgets/cloud_image_widget.dart';

class OrderQuestionWidget extends StatefulWidget {
  const OrderQuestionWidget({
    super.key,
    required this.question,
    required this.topic,
    required this.module,
    required this.sessionQuestion,
    required this.setParentState,
  });

  final OrderQuestion question;
  final SessionQuestion sessionQuestion;
  final Topic topic;
  final Module module;
  final void Function(void Function()) setParentState;

  @override
  State<OrderQuestionWidget> createState() => _OrderQuestionWidgetState();
}

class _OrderQuestionWidgetState extends State<OrderQuestionWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final cards = (widget.sessionQuestion.userAnswer as List<int>)
        .asMap()
        .entries
        .map((entry) {
      final num = entry.key;
      final answerNum = entry.value;
      final answer = widget.question.answers[answerNum];
      final isRightAnswer = (widget.sessionQuestion.isRight != null)
          ? widget.question.rightAnswersNumbersOrder[num] == answerNum
          : false;
      final isResult = widget.sessionQuestion.isRight != null;
      return Card(
        key: Key(
            '${widget.topic.dirName}_${widget.module.dirName}_${widget.question.number}_${answer.number}'),
        shadowColor: null,
        elevation: 2,
        color: (isResult && !isRightAnswer)
            ? theme.colorScheme.errorContainer
            : (isRightAnswer)
                ? theme.colorScheme.primaryContainer
                : theme.colorScheme.tertiaryContainer,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
            child: Column(
              children: [
                if (answer.text != null)
                  Text(
                    answer.text!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: (isResult && !isRightAnswer)
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
          ),
        ),
      );
    }).toList();

    return Column(
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ReorderableListView(
              shrinkWrap: true,
              buildDefaultDragHandles: widget.sessionQuestion.isRight == null,
              onReorder: (int oldIndex, int newIndex) {
                setState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final int item =
                      widget.sessionQuestion.userAnswer.removeAt(oldIndex);
                  widget.sessionQuestion.userAnswer.insert(newIndex, item);
                });
              },
              proxyDecorator:
                  (Widget child, int index, Animation<double> animation) {
                return AnimatedBuilder(
                  animation: animation,
                  builder: (BuildContext context, Widget? child) {
                    final double animValue =
                        Curves.easeInOut.transform(animation.value);
                    final double elevation = lerpDouble(1, 6, animValue)!;
                    final double scale = lerpDouble(1, 1.02, animValue)!;
                    return Transform.scale(
                      scale: scale,
                      child: Card(
                        elevation: elevation,
                        color: theme.colorScheme.secondaryContainer,
                        child: cards[index].child,
                      ),
                    );
                  },
                  child: child,
                );
              },
              children: cards),
        ),
        const SizedBox(height: 20,),
        Text((widget.sessionQuestion.isRight != null)? "Правильный ответ:": "(удерживайте для перемещения)"),
        if (widget.sessionQuestion.isRight != null)
          ListView.builder(
              shrinkWrap: true,
              itemCount: widget.question.answersCount,
              itemBuilder: (BuildContext context, int index) {
                final answer = widget.question
                    .answers[widget.question.rightAnswersNumbersOrder[index]];
                return Column(
                  children: [
                    Text(
                      '${index + 1}. ${answer.text ?? ""}',
                      style: TextStyle(
                        color: (widget.question.rightAnswersNumbersOrder[index] == widget.sessionQuestion.userAnswer[index])
                            ? theme.colorScheme.primary
                            : theme.colorScheme.error,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (answer.image != null)
                      CloudImageWidget(
                        topicDir: widget.topic.dirName,
                        imageName: widget.question.getImage()!,
                      ),
                  ],
                );
              })
      ],
    );
  }
}
