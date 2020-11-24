import 'package:flutter/material.dart';
import 'package:flutterfiretest/overview/models/deck.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'dart:math';

class CardTile extends StatelessWidget {

  final FlashCard card;
  CardTile({this.card});

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
                        child: Text(card.deckId),
                        foregroundColor: Colors.white,
                      ),
                      title: Text(card.front),
                      subtitle: Text(card.back),
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

