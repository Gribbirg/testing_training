import 'package:flutter/material.dart';
import 'package:testing_training/main.dart';

class ComingSoonWidget extends StatelessWidget {
  const ComingSoonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(path('images/logo.png')),
                Text("Скоро будет добавлено!", style: Theme.of(context).textTheme.displayMedium, textAlign: TextAlign.center,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
