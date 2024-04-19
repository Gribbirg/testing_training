import 'package:flutter/material.dart';

import '../main.dart';

AppBar getAppBar(BuildContext context, { required String text, List<Widget>? actions }) {
  final theme = Theme.of(context);
  return AppBar(
    shape: Border(
        bottom: BorderSide(color: theme.colorScheme.outlineVariant, width: 1)),
    // leading: Image.asset(path('images/logo.png')),
    title: Text(
      text,
      style: TextStyle(color: theme.colorScheme.onBackground),
    ),
    backgroundColor: theme.colorScheme.background,
    elevation: 10,
    actions: actions ?? [],
  );
}
