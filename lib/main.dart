import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:testing_training/repositories/topic_list/topic_list.dart';
import 'package:testing_training/router/router.dart';
import 'package:testing_training/theme/theme.dart';

void main() {

  GetIt.I.registerLazySingleton<AbstractTopicListRepository>(
        () => TopicListRepository(
            topicsListJsonPath:  _path('questions/topics.json')
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
    return MaterialApp.router(
      title: "Подготовка к ЦТ",
      theme: getTheme(),
      darkTheme: getTheme(darkMode: true),
      themeMode: ThemeMode.system,
      routerConfig: _router.config(),
    );
  }}

String _path(String str) {
  return (!kIsWeb) ? 'assets/$str' : str;
}