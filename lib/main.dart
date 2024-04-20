import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:testing_training/repositories/questions/questions.dart';
import 'package:testing_training/router/router.dart';
import 'package:testing_training/theme/theme.dart';

void main() {
  GetIt.I.registerLazySingleton<AbstractQuestionsRepository>(
    () =>
        QuestionsRepository(
            topicsListJsonPath: path('questions/topics.json'),
            questionsPath: path('questions'),
        ),
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
