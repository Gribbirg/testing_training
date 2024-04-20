import 'package:flutter/material.dart';

AppBar getAppBar(BuildContext context,
    {required String text, List<Widget>? actions}) {
  final theme = Theme.of(context);
  return AppBar(
    // leading: Image.asset(path('images/logo.png')),
    title: Text(
      text,
    ),
    actions: actions ?? [],
  );
}
