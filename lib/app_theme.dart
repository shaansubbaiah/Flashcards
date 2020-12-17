import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static Color _onError = Colors.red;

  static const Color _lightSurface = Color(0xffffffff);
  static const Color _lightBackground = Color(0xfff5f6f7);
  static const Color _lightPrimaryText = Color(0xff162a72);
  static const Color _lightSecondaryText = Color(0xffaab2cb);
  static const Color _lightAccent = Color(0xff3266eb);

  static const Color _darkSurface = Color(0xff273152);
  static const Color _darkBackground = Color(0xff202844);
  static const Color _darkPrimaryText = Color(0xffffffff);
  static const Color _darkSecondaryText = Color(0xff767b8a);
  static const Color _darkAccent = Color(0xff3266eb);

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: _lightBackground,
    colorScheme: ColorScheme.light(
      surface: _lightSurface,
      background: _lightBackground,
      primary: _lightPrimaryText,
      secondary: _lightSecondaryText,
      primaryVariant: _lightAccent,
      onError: _onError,
    ),
    appBarTheme: AppBarTheme(elevation: 0.0),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: _darkBackground,
    colorScheme: ColorScheme.light(
      surface: _darkSurface,
      background: _darkBackground,
      primary: _darkPrimaryText,
      secondary: _darkSecondaryText,
      primaryVariant: _darkAccent,
      onError: _onError,
    ),
    appBarTheme: AppBarTheme(elevation: 0.0),
  );
}

// background - kinda obvious
// surface - cards, botton navbar, etc that appear directly over the background
// primary - main text, most contrast
// secondary - description and tips, less contrast
// primaryvariant (accent) - color that pops ... contd. below
// on the surface/bg for the form border or whatever, where color is required
