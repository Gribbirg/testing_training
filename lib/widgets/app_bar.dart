import 'package:flutter/material.dart';

import '../main.dart';

AppBar getAppBar(BuildContext context,
    {required String text, Widget? leading}) {
  // final theme = Theme.of(context);
  return AppBar(
    leading: leading,
    forceMaterialTransparency: true,
    title: Text(
      text,
      textAlign: TextAlign.center,
    ),
    actions: [
      Image.asset(path('images/logo.png')),
      const SizedBox(
        width: 15,
      )
    ],
  );
}
