import 'package:flutter/material.dart';
import 'package:flutterfiretest/addDeck/add_deck_page.dart';
import 'package:flutterfiretest/overview/overview_page.dart';
import 'package:flutterfiretest/profile_page.dart';
import 'package:flutterfiretest/settings_page.dart';
import 'package:provider/provider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'gamePage/game.dart';

import 'auth_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Overview(),
    AddCard(),
    Settings(),
    Profile(),
    GamePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Home"),
      //   actions: <Widget>[
      //     Padding(
      //         padding: EdgeInsets.only(right: 20.0),
      //         child: IconButton(
      //           icon: Icon(Icons.exit_to_app),
      //           tooltip: "Signout",
      //           onPressed: () {
      //             context.read<AuthService>().signOut();
      //           },
      //         ))
      //   ],
      // ),
      body: _children[_currentIndex],
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.teal[400],
        // buttonBackgroundColor: Colors.teal[700],
        backgroundColor: Colors.white,
        height: 50,
        animationDuration: Duration(milliseconds: 300),
        items: <Widget>[
          Icon(Icons.home, color: Colors.white, size: 30),
          Icon(Icons.add, color: Colors.white, size: 30),
          Icon(Icons.settings, color: Colors.white, size: 30),
          Icon(Icons.perm_identity, color: Colors.white, size: 30),
          Icon(Icons.play_arrow, color: Colors.white, size: 30),
        ],
        onTap: (int index) {
          debugPrint(index.toString());
          setState(() {
            this._currentIndex = index;
          });
        },
      ),
    );
  }
}
