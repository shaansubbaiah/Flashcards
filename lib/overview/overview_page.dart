import 'package:flutter/material.dart';
import 'package:flutterfiretest/database.dart';
import 'package:provider/provider.dart';
import 'package:flutterfiretest/overview/deck_list.dart';
import 'package:flutterfiretest/overview/models/deck.dart';

class Overview extends StatefulWidget {
  @override
  _OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Deck>>.value(
        value: DatabaseService().decks,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primaryVariant,
            title: Center(
              child: Text(
                "Decks",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ),
          body: DeckList(),
        ));
  }
}
