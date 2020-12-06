import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:flutterfiretest/database.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final currentDeck = "v4VFWkP6JQGAfuCPhBf8";
  var flashcards;

  @override
  Widget build(BuildContext context) {
    // final flashcards = Provider.of<List<FlashCard>>(context);
    DatabaseService()
        .getCardDetails(currentDeck)
        .then((value) => {
              print(value),
              flashcards = value,
              print("Total cards:" + flashcards.length.toString()),
            })
        .catchError((err) => {
              print(err),
              flashcards = [],
            });

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
      child: Column(children: [
        Text("Rate difficulty:"),
        Row(
          children: [
            OutlinedButton(
              onPressed: () => {debugPrint("very hard")},
              child: Text("Very Hard"),
            ),
            OutlinedButton(
              onPressed: () => {debugPrint("okay")},
              child: Text("Okay"),
            ),
            OutlinedButton(
              onPressed: () => {debugPrint("easy")},
              child: Text("Easy"),
            ),
          ],
        )
      ]),
    );
    //   ],
    // );
  }
}
