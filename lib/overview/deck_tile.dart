import 'package:flutter/material.dart';
import 'package:flutterfiretest/overview/models/deck.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'dart:math';

class DeckTile extends StatelessWidget {
  final Deck deck;
  Function setIndex;
  DeckTile(this.deck, this.setIndex);

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
                setIndex(6);
              },
            ),
            IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () => debugPrint('Delete'),
            ),
          ],
        ),
      ]),
    );
  }
}
