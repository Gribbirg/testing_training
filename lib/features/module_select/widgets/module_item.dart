import 'package:flutter/material.dart';

import '../../../repositories/module_list/models/module.dart';

class ModuleItem extends StatelessWidget {
  const ModuleItem({super.key, required this.module});

  final Module module;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
        onPressed: () {

        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 10,
                child: Text(
                  module.name,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(width: 5,),
              Expanded(
                flex: 4,
                child: Text(
                  "Кол-во: ${module.questionsCount}",
                  style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ));
  }
}
