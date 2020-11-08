import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flashcard/services/auth.dart';
import 'package:flashcard/wrapper.dart';
import 'package:flashcard/home/profile.dart';
import 'package:flashcard/home/settings.dart';
import 'package:flashcard/home/addCard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),

        routes: <String, WidgetBuilder>
        {
        "/profile": (BuildContext context) => new Profile(),
        "/settings": (BuildContext context) => new Settings(),
        "/addCard": (BuildContext context) => new AddCard(),
        }
      ),
    );
  }
}
