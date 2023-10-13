import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData defaultTheme = ThemeData(
    primaryColor: AppColours.appBarColour,
    hintColor: AppColours.accentColor,
    // Define other default theme properties here
  );

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: AppColours.appBarColour,
    hintColor: AppColours.accentColor,
    // Customize light theme properties here
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: AppColours.appBarColour,
    hintColor: AppColours.accentColor,
    // Customize dark theme properties here
  );
}

class AppColours {
  static const Color appBarColour = Color.fromARGB(255, 104, 182, 128);
  static const Color accentColor = Colors.blue;
}
class AppFonts{

}