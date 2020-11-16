import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterfiretest/auth_service.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              tooltip: "Signout",
              onPressed: () {
                context.read<AuthService>().signOut();
              },
            ),
            Text("Logout :(")
          ],
        ),
      ),
    );
  }
}
