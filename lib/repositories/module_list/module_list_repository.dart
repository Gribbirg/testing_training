import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:testing_training/repositories/module_list/abstract_module_list_repository.dart';
import 'package:testing_training/repositories/module_list/models/module.dart';
import 'package:testing_training/repositories/topic_list/models/topic.dart';

class ModuleListRepository extends AbstractModuleListRepository {
  final String questionsPath;

  ModuleListRepository({required this.questionsPath});

  @override
  Future<List<Module>?> getModules(Topic topic) async {
    final String response = await rootBundle
        .loadString("$questionsPath/${topic.dirName}/modules.json");

    final data = await json.decode(response);

    final list =
        (data as List<dynamic>).map((e) => Module.fromJson(e)).toList();

    return list;
  }
}
