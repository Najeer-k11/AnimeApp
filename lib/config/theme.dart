import 'package:flutter/material.dart' ;

ThemeData lightTheme = ThemeData.light().copyWith(

  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange,brightness: Brightness.light)
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange,brightness: Brightness.dark),
  brightness: Brightness.dark
);