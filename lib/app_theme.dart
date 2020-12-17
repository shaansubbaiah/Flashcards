import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // static Color _iconColor = Colors.white;
  static Color _onError = Colors.red;

  // static const Color _lightPrimaryColor = Colors.deepPurple;
  // static const Color _lightPrimaryVariantColor = Colors.white;
  // static const Color _lightSecondaryColor = Color(0xffEDEDED);
  // static const Color _lightOnPrimaryColor = Colors.black;
  // static const Color _lightOnSecondaryColor = Color(0xff9E9D9D);
  // static const Color _lightOnError = Colors.red;
  static const Color _lightSurface = Color(0xffffffff);
  static const Color _lightBackground = Color(0xfff5f6f7);
  static const Color _lightPrimaryText = Color(0xff162a72);
  static const Color _lightSecondaryText = Color(0xffaab2cb);
  static const Color _lightAccent = Color(0xff3266eb);

  // static const Color _darkPrimaryColor = Colors.cyanAccent;
  // static const Color _darkPrimaryVariantColor = Colors.black;
  // static const Color _darkSecondaryColor = Color(0xff1E1E1E);
  // static const Color _darkOnPrimaryColor = Colors.white;
  // static const Color _darkOnSecondaryColor = Color(0xff909090);
  // static const Color _darkOnError = Colors.red;
  static const Color _darkSurface = Color(0xff273152);
  static const Color _darkBackground = Color(0xff202844);
  // static const Color _darkSurface = Color(0xff17388e);
  // static const Color _darkBackground = Color(0xff0d2162);
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
    // iconTheme: IconThemeData(
    //   color: _iconColor,
    // ),
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
    // iconTheme: IconThemeData(
    //   color: _iconColor,
    // ),
    appBarTheme: AppBarTheme(elevation: 0.0),
  );
}

// background - kinda obvious
// surface - cards, botton navbar, etc that appear directly over the background
// primary - main text, most contrast
// secondary - description and tips, less contrast
// primaryvariant (accent) - color that pops ... contd. below
// on the surface/bg for the form border or whatever, where color is required

// old
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
