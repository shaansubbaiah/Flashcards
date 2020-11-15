import 'package:flutter/material.dart';
import 'package:flutterfiretest/sign_in_page.dart';
import 'package:flutterfiretest/register_page.dart';

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
      return SignInPage(toggle: toggle);
    } else {
      return RegisterPage();
    }
  }
}
