import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

const Color mainColor = Colors.black;
const Color secondColor = Color(0xFF673AB7); //Color(0xffFF5C00);
Color backgroundColor =
    Color.fromARGB(255, 145, 81, 255); //Color.fromARGB(255, 255, 110, 26);
const Color grayColor = Color(0xffA8AFB9);
const Color lighterGray = Color.fromARGB(255, 229, 231, 235);
ThemeData appTheme = ThemeData(
    canvasColor: const Color(0xffF9FAFB),
    primarySwatch: Colors.deepPurple,
    fontFamily: 'Poppins',
    textTheme: TextTheme(
        titleLarge: TextStyle(
            color: mainColor, fontSize: 20.sp, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(
            color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.bold),
        labelMedium: TextStyle(
            color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w600),
        titleSmall: TextStyle(color: Colors.black, fontSize: 16.sp),
        bodySmall: TextStyle(
            fontSize: 14.sp,
            color: Color.fromARGB(255, 109, 109, 109),
            fontWeight: FontWeight.w600),
        labelSmall: TextStyle(
            color: grayColor, fontWeight: FontWeight.w600, fontSize: 14.sp)));

enum CarType { forRenting, forSelling }

const List<String> governrates = [
  'Homs',
  'Damascus',
  'Rif Dimashq',
  'Hama',
  'Aleppo',
  'Tartus',
  'Raqqa',
  'Suwayda',
  'Daraa',
  'Deir ez-Zor',
  'Al-Hasakah',
  'Idlib',
  'Latakia',
  'Quneitra',
];
