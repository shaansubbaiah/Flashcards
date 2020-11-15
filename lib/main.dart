import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutterfiretest/auth.dart';
import 'package:flutterfiretest/auth_service.dart';
import 'package:flutterfiretest/home_page.dart';
import 'package:flutterfiretest/profile_page.dart';
import 'package:flutterfiretest/settings_page.dart';
import 'package:flutterfiretest/add_card_page.dart';
import 'package:provider/provider.dart';

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
        )
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: AuthenticationWrapper(),
          routes: <String, WidgetBuilder>{
            "/profile": (BuildContext context) => new Profile(),
            "/settings": (BuildContext context) => new Settings(),
            "/addCard": (BuildContext context) => new AddCard(),
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
