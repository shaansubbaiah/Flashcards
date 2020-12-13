import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterfiretest/addDeck/add_deck_page.dart';
import 'package:flutterfiretest/overview/edit_deck_page.dart';
import 'package:flutterfiretest/overview/overview_page.dart';
import 'package:flutterfiretest/profile/profile_page.dart';
import 'package:flutterfiretest/settings/edit_user.dart';
import 'package:flutterfiretest/settings/settings_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutterfiretest/gamePage/game.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  int _selectedIndex = 0;
  List<Widget> _children;

  Settings settings;
  EditUser editUser;
  AddCard addCard;
  Overview overview;
  EditDeck editDeck;
  GamePage gamePage;

  List<int> pages = [];

  @override
  void initState() {
    super.initState();
    settings = new Settings(this.setIndex);
    editUser = new EditUser(this.setIndex);
    addCard = new AddCard(this.setIndex);
    overview = new Overview(this.setIndex);
    editDeck = new EditDeck(this.setIndex);
    gamePage = new GamePage(this.setIndex);
    _children = [
      overview,
      addCard,
      settings,
      Profile(),
      gamePage,
      editUser,
      editDeck,
    ];
  }

  void setIndex(int index) {
    setState(() {
      _currentIndex = index;
      if ((index == 0) || (index == 6)) {
        _selectedIndex = 0;
      } else if ((index == 2) || (index == 5)) {
        _selectedIndex = 2;
      } else if (index == 3) {
        _selectedIndex = 3;
      } else if (index == 4) {
        _selectedIndex = 4;
      } else if (index == 1) {
        _selectedIndex = 1;
      }
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
          index: _selectedIndex,
        ),
      ),
    );
  }
}
