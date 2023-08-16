import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

SnackBar customSnackBar(message, color) => SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      backgroundColor: color.shade400,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.w))),
      content: Text(message),
    );

void showSnackBar(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    customSnackBar(message, color),
  );
}
