import 'package:flutter/material.dart';

class AppTheme {

  static const Color primary = Colors.indigo;

  static ThemeData getTheme(bool isDarkMode) {
    return (isDarkMode ? ThemeData.dark() : ThemeData.light()).copyWith(
      // Color Primario
      primaryColor: primary,

      //AppBar Theme
      appBarTheme: const AppBarTheme(
        color: primary,
        elevation: 2
      ),

      switchTheme: SwitchThemeData(
        trackColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return primary.withOpacity(.80);
          }
          return primary.withOpacity(.48);
        }),
        thumbColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return primary.withOpacity(.48);
          }
          return primary;
        })
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: primary,
        selectedIconTheme: IconThemeData(color: primary),
        selectedLabelStyle: TextStyle(
          color: primary
        )
      ),

      //TextButton Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom( foregroundColor: primary )
      ),

      iconTheme: const IconThemeData(
        color: Colors.white
      ),

      //FloatingActionButton Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primary,
        elevation: 5
      ),

      //ElevatedButton
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          shape: const StadiumBorder(),
          elevation: 0
        )
      ),

      //Input
      inputDecorationTheme: const InputDecorationTheme(
        floatingLabelStyle: TextStyle(
          color: primary
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primary),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), topRight: Radius.circular(10))
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primary),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), topRight: Radius.circular(10))
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), topRight: Radius.circular(10))
        )
      )
    );
  }
}