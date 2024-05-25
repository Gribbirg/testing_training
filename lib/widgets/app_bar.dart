import 'package:flutter/material.dart';

import '../main.dart';

AppBar getAppBar(BuildContext context,
    {required String text}) {
  // final theme = Theme.of(context);
  return AppBar(
    // leading: Image.asset(path('images/logo.png')),
    title: Text(
      text,
    ),
    actions: [
      Image.asset(path('images/logo.png')),
      const SizedBox(
        width: 15,
      )
    ],
  );
}
