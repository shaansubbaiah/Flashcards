import 'package:flashcard/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: IconButton(
                icon: Icon(Icons.exit_to_app),
                tooltip: "Signout",
                onPressed: () async {
                  await _auth.signOut();
                },
              ))
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blueAccent,
        items: <Widget>[
          Icon(Icons.add, size: 30),
          Icon(Icons.home, size: 30),
          Icon(Icons.settings, size: 30),
          Icon(Icons.perm_identity, size: 30),
        ],
        onTap: (index) {
          print(index);
          //Handle button tap

          if(index == 0){
            Navigator.popAndPushNamed(context, "/addCard");
          } else if(index == 1) {
            // Navigator.popAndPushNamed(context, "/settings");
          } else if(index == 2) {
            Navigator.popAndPushNamed(context, "/settings");
          } else {
            Navigator.popAndPushNamed(context, "/profile");
          }
        },
      ),
      body: Container(
        child: Text(""),
      ),
    );
  }
}
