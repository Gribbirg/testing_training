import 'package:flutter/material.dart';
import 'package:testing_training/main.dart';

class ComingSoonWidget extends StatelessWidget {
  const ComingSoonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(path('images/logo_shadow.png')),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Text("Скоро будет добавлено!", style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 30,), textAlign: TextAlign.center,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
