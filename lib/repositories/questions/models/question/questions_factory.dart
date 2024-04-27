import 'package:testing_training/repositories/questions/models/models.dart';
import 'package:testing_training/repositories/questions/models/question/categories_question.dart';


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
      case QuestionType.multiSelectQuestion:
        return MultiSelectQuestion.fromJson(json);
      case QuestionType.categoriesQuestion:
        return CategoriesQuestion.fromJson(json);
      case QuestionType.orderQuestion:
        return OrderQuestion.fromJson(json);
    }
  }
}

enum QuestionType {
  oneSelectQuestion(jsonName: "oneselect"),
  stringQuestion(jsonName: "string"),
  numQuestion(jsonName: "num"),
  multiSelectQuestion(jsonName: "multselect"),
  categoriesQuestion(jsonName: "categories"),
  orderQuestion(jsonName: "order"),
  ;

  final String jsonName;

  const QuestionType({required this.jsonName});

  static QuestionType getByJsonName(String jsonName) {
    return QuestionType.values
        .firstWhere((element) => element.jsonName == jsonName);
  }
}
