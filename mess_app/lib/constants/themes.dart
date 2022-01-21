import 'package:flutter/material.dart';
import 'package:mess_app/constants/colors.dart';

class Themes {
  static final darkTheme = ThemeData(
    backgroundColor: kPrimaryColor,
    accentColorBrightness: Brightness.dark,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      surface: kPrimaryColor,
      onSurface: Colors.black,
      primary: kPrimaryColor,
      onPrimary: Colors.white,
      primaryVariant: kPrimaryColor,
      secondary: Colors.grey,
      secondaryVariant: Colors.grey,
      onSecondary: Colors.grey,
      background: Colors.grey,
      onBackground: Colors.grey,
      error: Colors.red,
      onError: Colors.white,
    ),
  );

  static final lightTheme = ThemeData(
    backgroundColor: kPrimaryColor,
    accentColorBrightness: Brightness.dark,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      surface: kPrimaryColor,
      onSurface: Colors.black,
      primary: kPrimaryColor,
      onPrimary: Colors.white,
      primaryVariant: kPrimaryColor,
      secondary: Colors.grey,
      secondaryVariant: Colors.grey,
      onSecondary: Colors.grey,
      background: Colors.grey,
      onBackground: Colors.grey,
      error: Colors.red,
      onError: Colors.white,
    ),
  );
}
