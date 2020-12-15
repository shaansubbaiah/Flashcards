import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static Color _iconColor = Colors.white;

  static const Color _lightPrimaryColor = Colors.teal;
  static const Color _lightPrimaryVariantColor = Colors.white;
  static const Color _lightSecondaryColor = Color(0xffEDEDED);
  static const Color _lightOnPrimaryColor = Colors.black;
  static const Color _lightOnSecondaryColor = Color(0xff9E9D9D);
  static const Color _lightOnError = Colors.red;
  static const Color _lightSurface = Color(0xffffff);
  static const Color _lightBackground = Color(0xf5f6f7);

  static const Color _darkPrimaryColor = Color(0xffBB86FC);
  static const Color _darkPrimaryVariantColor = Colors.black;
  static const Color _darkSecondaryColor = Color(0xff1E1E1E);
  static const Color _darkOnPrimaryColor = Colors.white;
  static const Color _darkOnSecondaryColor = Color(0xff909090);
  static const Color _darkOnError = Colors.red;
  static const Color _darkSurface = Color(0x212435);
  static const Color _darkBackground = Color(0x1c1e2c);

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: _lightPrimaryVariantColor,
    colorScheme: ColorScheme.light(
      surface: _lightSurface,
      background: _lightBackground,
      primary: _lightPrimaryColor,
      primaryVariant: _lightPrimaryVariantColor,
      secondary: _lightSecondaryColor,
      onPrimary: _lightOnPrimaryColor,
      onSecondary: _lightOnSecondaryColor,
      onError: _lightOnError,
    ),
    iconTheme: IconThemeData(
      color: _iconColor,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: _darkPrimaryVariantColor,
    colorScheme: ColorScheme.light(
      surface: _darkSurface,
      background: _darkBackground,
      primary: _darkPrimaryColor,
      primaryVariant: _darkPrimaryVariantColor,
      secondary: _darkSecondaryColor,
      onPrimary: _darkOnPrimaryColor,
      onSecondary: _darkOnSecondaryColor,
      onError: _darkOnError,
    ),
    iconTheme: IconThemeData(
      color: _iconColor,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
    ),
  );
}

// primary - navigation bottom, textfield(cursor,text,border),
//         Button background(signin,register,edit), button text(for flat button)
// primaryVariant - alert background, page background, navigation icon,
//                  button text(siginin,register,edit), appbar background
// secondary - forgot password text, container background in add deck,
//             card tile background
// onPrimary - alert title, appbar title, text(already have acc, create acc),
//             deck and tag fieldname, card tile title
// onSecondary - alert content, textfield(cursor,text) in add deck,
//               card tile subtitle, settings page(text,icon,border)
// onError - required text in add deck
