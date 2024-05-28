import 'package:flutter/material.dart';

void showTextSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      text,
      textAlign: TextAlign.center,
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 10,
    showCloseIcon: true,
    behavior: SnackBarBehavior.floating,
    width: 300,
  ));
}
