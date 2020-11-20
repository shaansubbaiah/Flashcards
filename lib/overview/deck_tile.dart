import 'package:flutter/material.dart';
import 'package:flutterfiretest/overview/models/deck.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'dart:math';

class DeckTile extends StatelessWidget {

  final Deck deck;
  DeckTile({this.deck});

  @override
  Widget build(BuildContext context) {

   return  Container(
            child: Column(
            children:[
              Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  child: Container(
                    color: Colors.white,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25.0,
                        backgroundColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                        child: Text(deck.tag),
                        foregroundColor: Colors.white,
                      ),
                      title: Text(deck.deckname),
                      subtitle: Text(deck.desc),
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
                      onTap: () => debugPrint('Edit'),
                    ),
                    IconSlideAction(
                      caption: 'Delete',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () => debugPrint('Delete'),
                    ),
                  ],
                ),
            ]
            ),
            );
  }
}

