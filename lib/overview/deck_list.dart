import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterfiretest/overview/models/deck.dart';
import 'package:flutterfiretest/overview/deck_tile.dart';

class deckList extends StatefulWidget {
  @override
  _deckListState createState() => _deckListState();
}

class _deckListState extends State<deckList> {
  @override
  Widget build(BuildContext context) {
    final decks = Provider.of<List<Deck>>(context);
    // decks.forEach((deck) {
    //   print(deck.deckname);
    //   print(deck.desc);
    //   print(deck.tag);
    // });

    return ListView.builder(
      itemCount: decks != null ? decks.length : 0,
      itemBuilder: (context, index) {
        return DeckTile(deck: decks[index]);
      },
    );
  }
}
