import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:testing_training/repositories/questions/models/question/categories_question.dart';
import 'package:testing_training/repositories/questions/questions.dart';
import 'package:testing_training/repositories/session_save/abstract_session_save_repository.dart';
import 'package:testing_training/repositories/session_save/session_save.dart';
import 'package:testing_training/repositories/settings/abstract_settings_repository.dart';
import 'package:testing_training/repositories/settings/model/color_settings.dart';
import 'package:testing_training/repositories/settings/model/model.dart';
import 'package:testing_training/repositories/settings/settings.dart';
import 'package:testing_training/testing_training_app.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await _initFirebase();
  await _initHive();
  await GetIt.instance.allReady();

  final Settings settings = await GetIt.I<AbstractSettingsRepository>().getUserSettings();

  runApp(TestingTrainingApp(userSettings: settings,));
  FlutterNativeSplash.remove();
}

String path(String str) {
  return 'assets/$str';
}

Future<void> _initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (!kDebugMode) {
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.playIntegrity,
      appleProvider: AppleProvider.appAttest,
      webProvider:
          ReCaptchaV3Provider('6Leyx8opAAAAAJ6pIfeiXGgbcP1mlfLwUwy4lBwk'),
    );
  } else {
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.debug,
      appleProvider: AppleProvider.debug,
      webProvider:
          ReCaptchaV3Provider('6Leyx8opAAAAAJ6pIfeiXGgbcP1mlfLwUwy4lBwk'),
    );
  }
  await FirebaseAuth.instance.signInAnonymously();
}

Future<void> _initHive() async {
  await Hive.initFlutter();

  Hive.registerAdapter(SessionQuestionAdapter());
  Hive.registerAdapter(SessionDataAdapter());

  Hive.registerAdapter(TopicAdapter());
  Hive.registerAdapter(ModuleAdapter());
  Hive.registerAdapter(AnswerAdapter());

  Hive.registerAdapter(OneSelectQuestionAdapter());
  Hive.registerAdapter(CategoriesQuestionAdapter());
  Hive.registerAdapter(MultiSelectQuestionAdapter());
  Hive.registerAdapter(NumQuestionAdapter());
  Hive.registerAdapter(OrderQuestionAdapter());
  Hive.registerAdapter(StringQuestionAdapter());

  Hive.registerAdapter(SettingsAdapter());
  Hive.registerAdapter(ColorSettingAdapter());

  final sessionsSaveBox = await Hive.openLazyBox('sessions');
  final questionsCacheBox = await Hive.openLazyBox('cache');
  final settingsBox = await Hive.openLazyBox('settings');
  // await questionsCacheBox.clear();

  GetIt.I.registerLazySingleton<AbstractSessionSaveRepository>(
    () => SessionSaveRepository(box: sessionsSaveBox),
  );
  GetIt.I.registerSingletonAsync<AbstractQuestionsRepository>(
    () async {
      final rep =
          QuestionsCloudWithCacheRepository(cacheBox: questionsCacheBox);
      await rep.checkUpdates();
      return rep;
    },
  );
  GetIt.I.registerLazySingleton<AbstractSettingsRepository>(
      () => SettingRepository(box: settingsBox));
}
