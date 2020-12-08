import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfiretest/app_theme.dart';

import 'package:flutterfiretest/auth.dart';
import 'package:flutterfiretest/auth_service.dart';
import 'package:flutterfiretest/home_page.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthService>().authStateChanges,
        ),
        ChangeNotifierProvider<AppState>(
          create: (_) => AppState(),
        ),
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: Provider.of<AppState>(context).isNightModeOn
              ? ThemeMode.dark
              : ThemeMode.light,
          home: AuthenticationWrapper(),
        );
      }),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseuser = context.watch<User>();

    if (firebaseuser != null) {
      return HomePage();
    } else {
      return Authenticate();
    }
  }
}
