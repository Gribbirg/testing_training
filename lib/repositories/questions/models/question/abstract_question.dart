import 'package:equatable/equatable.dart';
import 'package:testing_training/repositories/session_save/models/models.dart';

abstract class AbstractQuestion extends Equatable {
  int getNumber();

  String getName();

  String? getImage();

  void setAnswerRight(SessionQuestion sessionQuestion);

  void shuffleAnswersNum(SessionQuestion sessionQuestion);
}
