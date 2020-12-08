import 'package:flutter/material.dart';
import 'package:flutterfiretest/database.dart';
import 'package:provider/provider.dart';
import 'package:flutterfiretest/overview/models/deck.dart';
import 'package:flutterfiretest/overview/deck_tile.dart';

class DeckList extends StatefulWidget {
  @override
  _DeckListState createState() => _DeckListState();
}

class _DeckListState extends State<DeckList> {
  @override
  Widget build(BuildContext context) {
    final decks = Provider.of<List<Deck>>(context);
    // decks.forEach((deck) {
    //   print(deck.deckname);
    //   print(deck.desc);
    //   print(deck.tag);
    //   print(deck.deckid);
    // });

    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: ListView.builder(
        itemCount: decks != null ? decks.length : 0,
        itemBuilder: (context, index) {
          return DeckTile(deck: decks[index]);
        },
      ),
    );
  }
}
