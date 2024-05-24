
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';

class SessionStateWidget extends StatefulWidget {
  const SessionStateWidget(
      {super.key,
      required this.rightCount,
      required this.wrongCount,
      required this.completeCount,
      required this.questionsCount,
      required this.currentQuestionNum});

  final int rightCount;
  final int wrongCount;
  final int completeCount;
  final int questionsCount;
  final int currentQuestionNum;

  @override
  State<SessionStateWidget> createState() => _SessionStateWidgetState();
}

class _SessionStateWidgetState extends State<SessionStateWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:  8.0, vertical: 5,),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: _getRightWrongCounter()),
            Expanded(child: _getQuestionNumber()),
            Expanded(child: _getSolvedCounter())
          ],
        ),
      ),
    );
  }

  Widget _getRightWrongCounter() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(Icons.done, color: Theme.of(context).colorScheme.primary,),
        AnimatedFlipCounter(
          value: widget.rightCount,
          textStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
              fontSize: 15
          ),
        ),
        const SizedBox(width: 5,),
        Icon(Icons.dangerous, color: Theme.of(context).colorScheme.error,),
        AnimatedFlipCounter(
          value: widget.wrongCount,
          textStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
              fontSize: 15
          ),
        )
      ],
    );
  }

  Widget _getQuestionNumber() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("№", textAlign: TextAlign.center, style: TextStyle(fontSize: 15),),
        const SizedBox(width: 2,),
        AnimatedFlipCounter(
          value: max(widget.currentQuestionNum + 1, 1),
          textStyle: TextStyle(
            color: Theme.of(context).colorScheme.onSecondaryContainer,
            fontSize: 15
          ),
        )
      ],
    );
  }

  Widget _getSolvedCounter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AnimatedFlipCounter(
          value: widget.completeCount,
          textStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
              fontSize: 15
          ),
        ),
        const Text('/'),
        AnimatedFlipCounter(
          value: widget.questionsCount,
          textStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
              fontSize: 15
          ),
        ),
      ],
    );
  }
}
