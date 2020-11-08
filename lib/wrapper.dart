import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashcard/authenticate/authenticate.dart';
import 'package:flashcard/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
