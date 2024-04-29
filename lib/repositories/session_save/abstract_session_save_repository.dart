import 'package:testing_training/repositories/questions/models/models.dart';
import 'package:testing_training/repositories/session_save/models/models.dart';

abstract class AbstractSessionSaveRepository {
  Future<void> addSessionData(SessionData sessionData);
  Future<void> saveSessionData(SessionData sessionData);
  Future<SessionData?> getSessionData(Topic topic, Module module);
  Future<void> removeSessionData(SessionData sessionData);
  Future<void> removeAll();
}