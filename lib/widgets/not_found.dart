import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testing_training/main.dart';
import 'package:testing_training/router/router.dart';

class NotFoundWidget extends StatefulWidget {
  const NotFoundWidget({super.key});

  @override
  State<NotFoundWidget> createState() => _NotFoundWidgetState();
}

class _NotFoundWidgetState extends State<NotFoundWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Card(
              child: Container(
                constraints: const BoxConstraints(
                  maxHeight: 500,
                ),
                child: Image.asset(
                  path('images/grib_with_knife.png'),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Страница не найдена!',
              style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 30),
            ),
            const SizedBox(
              height: 40,
            ),
            FilledButton(
                onPressed: () {
                  AutoRouter.of(context).push(const HomeRoute());
                },
                child: const Text('На главную'))
          ],
        ),
      ),
    );
  }
}
