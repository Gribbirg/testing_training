import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testing_training/services/copy_text.dart';
import 'package:testing_training/widgets/snack_bar.dart';

import '../main.dart';
import '../router/router.dart';

class ErrorAppWidget extends StatefulWidget {
  const ErrorAppWidget({super.key, required this.exception});

  final Exception exception;

  @override
  State<ErrorAppWidget> createState() => _ErrorAppWidgetState();
}

class _ErrorAppWidgetState extends State<ErrorAppWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              children: [
                Card(
                  child: Image.asset(
                    path('images/angry_grib.png'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Произошла ошибка!',
                  style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 30),
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  color: Theme.of(context).colorScheme.errorContainer,
                  child: ListTile(
                    leading: Icon(
                      Icons.error,
                      color: Theme.of(context).colorScheme.onErrorContainer,
                    ),
                    title: Text(
                      widget.exception.toString(),
                      style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onErrorContainer),
                    ),
                    onTap: () {
                      copyText(widget.exception.toString());
                      showTextSnackBar(context, 'Скопировано');
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      OutlinedButton(onPressed: () {
                        AutoRouter.of(context).push(const AboutAppRoute());
                      }, child: const Text('Контакты разработчика')),
                      const SizedBox(width: 20,),
                      FilledButton(
                        onPressed: () {
                          AutoRouter.of(context).push(const HomeRoute());
                        },
                        child: const Text('На главную'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
