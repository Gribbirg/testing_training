import 'package:equatable/equatable.dart';
import 'package:testing_training/repositories/questions/models/question/question.dart';
import 'package:testing_training/repositories/session_save/models/models.dart';

abstract class AbstractQuestion extends Equatable {
  int getNumber();
  String getName();
  String? getImage();
  void setAnswerRight(SessionQuestion sessionQuestion);
  void shuffleAnswersNum(SessionQuestion sessionQuestion);
}

class QuestionFactory {
  static AbstractQuestion getQuestionFromJson(Map<String, dynamic> json) {
    final type = QuestionType.getByJsonName(json["type"]);

    switch (type) {
      case QuestionType.oneSelectQuestion:
        return OneSelectQuestion.fromJson(json);
      case QuestionType.stringQuestion:
        return StringQuestion.fromJson(json);
      case QuestionType.numQuestion:
        return NumQuestion.fromJson(json);
    }
  }
}

enum QuestionType {
  oneSelectQuestion(jsonName: "oneselect"),
  stringQuestion(jsonName: "string"),
  numQuestion(jsonName: "num");

  final String jsonName;

  const QuestionType({required this.jsonName});

  static QuestionType getByJsonName(String jsonName) {
    return QuestionType.values
        .firstWhere((element) => element.jsonName == jsonName);
  }
}
