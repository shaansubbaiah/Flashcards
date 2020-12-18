import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterfiretest/addDeck/add_deck_page.dart';
import 'package:flutterfiretest/overview/edit_deck_page.dart';
import 'package:flutterfiretest/overview/overview_page.dart';
import 'package:flutterfiretest/stats/stats_page.dart';
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
  StatsPage profile;

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
    profile = new StatsPage();

    _children = [
      overview,
      addCard,
      settings,
      profile,
      gamePage,
      editUser,
      editDeck,
    ];
  }

  void setIndex(int index) {
    setState(() {
      _currentIndex = index;

      // _selectedIndex changes which navbar option is bubbled/selected
      // highlight HOME ICON for overview, gamepage, editDeck
      if (index == 0 || index == 6 || index == 4)
        _selectedIndex = 0;
      // highlight GEAR ICON for settings, edituser
      else if (index == 2 || index == 5)
        _selectedIndex = 2;
      // else highlight the icon corresponding to the index
      else
        _selectedIndex = index;

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
        body: _children[_currentIndex],
        extendBody: true,
        bottomNavigationBar: CurvedNavigationBar(
          color: Theme.of(context).colorScheme.surface,
          // buttonBackgroundColor: Colors.teal[700],
          backgroundColor: Colors.transparent,
          height: 50,
          animationDuration: Duration(milliseconds: 300),
          items: <Widget>[
            Icon(EvaIcons.homeOutline,
                color: Theme.of(context).colorScheme.primary, size: 30),
            Icon(EvaIcons.plusOutline,
                color: Theme.of(context).colorScheme.primary, size: 30),
            Icon(EvaIcons.options2Outline,
                color: Theme.of(context).colorScheme.primary, size: 30),
            Icon(EvaIcons.barChartOutline,
                color: Theme.of(context).colorScheme.primary, size: 30),
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
