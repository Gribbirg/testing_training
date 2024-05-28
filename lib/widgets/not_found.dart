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
                  path('images/angry_grib.png'),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Страница не найдена!',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(
              height: 20,
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
