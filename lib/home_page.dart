import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterfiretest/addDeck/add_deck_page.dart';
import 'package:flutterfiretest/overview/edit_deck_page.dart';
import 'package:flutterfiretest/overview/overview_page.dart';
import 'package:flutterfiretest/profile/profile_page.dart';
import 'package:flutterfiretest/settings/edit_user.dart';
import 'package:flutterfiretest/settings/settings_page.dart';
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
  List<Widget> _children;

  Settings settings;
  EditUser editUser;
  AddCard addCard;
  Overview overview;
  EditDeck editDeck;

  List<int> pages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    settings = new Settings(this.setIndex);
    editUser = new EditUser(this.setIndex);
    addCard = new AddCard(this.setIndex);
    overview = new Overview(this.setIndex);
    editDeck = new EditDeck(this.setIndex);
    _children = [
      overview,
      addCard,
      settings,
      Profile(),
      GamePage(),
      editUser,
      editDeck,
    ];
  }

  void setIndex(int index) {
    setState(() {
      _currentIndex = index;
      pages.add(index);
    });
  }

  void backPressed() {
    if (pages.isEmpty) {
      SystemNavigator.pop();
    } else {
      int index = pages.removeLast();
      index = pages.removeLast();
      setIndex(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        backPressed();
        return;
      },
      child: Scaffold(
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
          color: Theme.of(context).colorScheme.primary,
          // buttonBackgroundColor: Colors.teal[700],
          backgroundColor: Colors.transparent,
          height: 50,
          animationDuration: Duration(milliseconds: 300),
          items: <Widget>[
            Icon(Icons.home,
                color: Theme.of(context).colorScheme.primaryVariant, size: 30),
            Icon(Icons.add,
                color: Theme.of(context).colorScheme.primaryVariant, size: 30),
            Icon(Icons.settings,
                color: Theme.of(context).colorScheme.primaryVariant, size: 30),
            Icon(Icons.perm_identity,
                color: Theme.of(context).colorScheme.primaryVariant, size: 30),
            Icon(Icons.play_arrow,
                color: Theme.of(context).colorScheme.primaryVariant, size: 30),
          ],
          onTap: (int index) {
            debugPrint(index.toString());
            setIndex(index);
          },
        ),
      ),
    );
  }
}
