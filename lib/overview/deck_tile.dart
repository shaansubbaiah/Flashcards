import 'package:flutter/material.dart';
import 'package:flutterfiretest/database.dart';
import 'package:flutterfiretest/overview/models/deck.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'dart:math';

import '../alert_dialog.dart';

class DeckTile extends StatefulWidget {
  final Deck deck;
  final Function setIndex;
  DeckTile(this.deck, this.setIndex);
  @override
  DeckTileState createState() => DeckTileState(this.deck, this.setIndex);
}

class DeckTileState extends State<DeckTile> {
  final Deck deck;
  final Function setIndex;
  DeckTileState(this.deck, this.setIndex);

  static String deckid;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: Padding(
            padding: EdgeInsets.only(top: 5, bottom: 5, right: 15, left: 15),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.all(
                  Radius.circular(25.0),
                ),
              ),
              // color: Colors.white,
              child: ListTile(
                onTap: () {
                  print('Tapped ${deck.deckid}');
                  setState(() {
                    deckid = deck.deckid;
                    // open the Game Page
                    setIndex(4);
                  });
                },
                leading: CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors
                      .primaries[Random().nextInt(Colors.primaries.length)],
                  child: Text(deck.tag),
                  foregroundColor: Colors.white,
                ),
                title: Text(
                  deck.deckname,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                ),
                subtitle: Text(
                  deck.desc + " " + deck.deckid,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary),
                ),
              ),
            ),
          ),
          actions: <Widget>[
            IconSlideAction(
              caption: 'Share',
              color: Colors.indigo,
              icon: Icons.share,
              onTap: () => debugPrint('Share'),
            ),
          ],
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'Edit',
              color: Colors.black45,
              icon: Icons.edit,
              onTap: () {
                print('Tapped to edit ${deck.deckid}');
                setState(() {
                  deckid = deck.deckid;
                });
                setIndex(6);
              },
            ),
            IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () async {
                print('Tapped to delete ${deck.deckid}');
                final action = await Dialogs.yesAbort(
                    context, "Delete Deck", "Are you sure?", "Delete", "No");

                if (action == DialogAction.yes) {
                  DatabaseService().deleteDeck(deck.deckid);
                }
                // DatabaseService().deleteDeck(deck.deckid);
              },
            ),
          ],
        ),
      ]),
    );
  }
}
