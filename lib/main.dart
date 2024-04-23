import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:testing_training/repositories/questions/questions.dart';
import 'package:testing_training/repositories/session_save/abstract_session_save_repository.dart';
import 'package:testing_training/repositories/session_save/session_save.dart';
import 'package:testing_training/router/router.dart';
import 'package:testing_training/theme/theme.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  Hive.registerAdapter(SessionQuestionAdapter());
  Hive.registerAdapter(SessionDataAdapter());
  final sessionsSaveBox = await Hive.openLazyBox("sessions");

  GetIt.I.registerLazySingleton<AbstractQuestionsRepository>(
    () => QuestionsRepository(
      topicsListJsonPath: path('questions/topics.json'),
      questionsPath: path('questions'),
    ),
  );
  GetIt.I.registerLazySingleton<AbstractSessionSaveRepository>(
    () => SessionSaveRepository(box: sessionsSaveBox),
  );

  runApp(const TestingTrainingApp());
}

class TestingTrainingApp extends StatefulWidget {
  const TestingTrainingApp({super.key});

  @override
  State<StatefulWidget> createState() => _TestingTrainingAppState();
}

class _TestingTrainingAppState extends State<TestingTrainingApp> {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
        builder: (ColorScheme? lightColorScheme, ColorScheme? darkColorScheme) {
      return MaterialApp.router(
        title: "Подготовка к ЦТ",
        theme: getTheme(colorTheme: lightColorScheme),
        darkTheme: getTheme(colorTheme: darkColorScheme, darkMode: true),
        themeMode: ThemeMode.system,
        routerConfig: _router.config(),
      );
    });
  }
}

String path(String str) {
  return (!kIsWeb) ? 'assets/$str' : str;
}
