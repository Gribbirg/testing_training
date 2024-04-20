import 'package:flutter/material.dart';
import 'package:testing_training/repositories/questions/models/question/abstract_question.dart';
import 'package:testing_training/repositories/questions/models/question/one_select_question.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget(
      {super.key,
      required this.question,
      required this.pageController,
      required this.isFirst,
      required this.isLast});

  final AbstractQuestion question;
  final PageController pageController;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    if (question is OneSelectQuestion) {
      return OneSelectQuestionWidget(
        question: question as OneSelectQuestion,
        pageController: pageController,
        isFirst: isFirst,
        isLast: isLast,
      );
    }

    return const CircularProgressIndicator();
  }
}

class OneSelectQuestionWidget extends StatelessWidget {
  const OneSelectQuestionWidget(
      {super.key,
      required this.question,
      required this.pageController,
      required this.isFirst,
      required this.isLast});

  final OneSelectQuestion question;
  final PageController pageController;
  final bool isFirst;
  final bool isLast;

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
                    onPressed: (isFirst) ? null : () {
                      pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    },
                    icon: const Icon(Icons.chevron_left)),
                Expanded(child: Text(question.name)),
                IconButton(
                    onPressed: (isLast)? null : () {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    },
                    icon: const Icon(Icons.chevron_right)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
