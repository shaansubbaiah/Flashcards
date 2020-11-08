import 'package:flashcard/authenticate/register.dart';
import 'package:flashcard/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggle() {
    setState(() {
      showSignIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggle: toggle);
    } else {
      return Register();
    }
  }
}
