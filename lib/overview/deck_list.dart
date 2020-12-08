import 'package:flutter/material.dart';
import 'package:flutterfiretest/database.dart';
import 'package:provider/provider.dart';
import 'package:flutterfiretest/overview/models/deck.dart';
import 'package:flutterfiretest/overview/deck_tile.dart';

class DeckList extends StatefulWidget {
  Function setIndex;
  DeckList(this.setIndex);
  @override
  _DeckListState createState() => _DeckListState(this.setIndex);
}

class _DeckListState extends State<DeckList> {
  Function setIndex;
  _DeckListState(this.setIndex);
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
          return DeckTile(decks[index], this.setIndex);
        },
      ),
    );
  }
}
