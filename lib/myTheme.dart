import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryLight = Color(0xff5D9CEC);
  static Color backgroundLight = Color(0xffdfecdb);
  static Color greenColor = Color(0xff61E757);
  static Color greyColor = Color(0xffa8a9a9);
  static Color redColor = Color(0xffEC4B4B);
  static Color blackColor = Color(0xff200E32);
  static Color whiteColor = Color(0xffFFFFFF);
  static Color backgroundDark = Color(0xff060e1e);
  static Color blackColorDark = Color(0xff141922);
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: backgroundLight,
      appBarTheme: AppBarTheme(backgroundColor: primaryLight, elevation: 0),
      textTheme: TextTheme(
        titleLarge: TextStyle(
            fontSize: 22, fontWeight: FontWeight.bold, color: whiteColor),
        titleSmall: TextStyle(
            fontSize: 12, fontWeight: FontWeight.normal, color: blackColor),
        titleMedium: TextStyle(
            fontSize: 14, fontWeight: FontWeight.normal, color: primaryLight),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryLight,
          unselectedItemColor: greyColor,
          backgroundColor: Colors.transparent,
          elevation: 0,
          showUnselectedLabels: false,
          showSelectedLabels: false),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryLight,
          iconSize: 30,
          shape: StadiumBorder(side: BorderSide(color: whiteColor, width: 4))));
  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: backgroundDark,
      appBarTheme: AppBarTheme(backgroundColor: primaryLight, elevation: 0),
      textTheme: TextTheme(
        titleLarge: TextStyle(
            fontSize: 22, fontWeight: FontWeight.bold, color: blackColor),
        titleSmall: TextStyle(
            fontSize: 12, fontWeight: FontWeight.normal, color: whiteColor),
        titleMedium: TextStyle(
            fontSize: 14, fontWeight: FontWeight.normal, color: primaryLight),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryLight,
          unselectedItemColor: whiteColor,
          backgroundColor: Colors.transparent,
          elevation: 0,
          showUnselectedLabels: false,
          showSelectedLabels: false),
      bottomAppBarTheme: BottomAppBarTheme(color: blackColorDark),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryLight,
          iconSize: 30,
          shape: StadiumBorder(
              side: BorderSide(color: blackColorDark, width: 4))));
}
