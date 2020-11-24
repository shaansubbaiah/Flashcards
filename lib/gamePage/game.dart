import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:provider/provider.dart';
import 'package:flutterfiretest/gamePage/card_tile.dart';
import 'package:flutterfiretest/overview/models/deck.dart';


class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  // var cardContent = [
  //   {
  //     "question": "What is your name",
  //     "answer": "Flutterther",
  //   },
  //   {
  //     "question": "What is the color of an orange",
  //     "answer": "Orange",
  //   },
  //   {
  //     "question": "What is 2+2",
  //     "answer": "4",
  //   },
  //   {
  //     "question": "What is 2+2",
  //     "answer": "4",
  //   },
  //   {
  //     "question": "What is 2+2",
  //     "answer": "4",
  //   },
  // ];

  // debugPrint(cardContent[index]["question"]);

  CardController controller;

  @override
  Widget build(BuildContext context) {

    final cards = Provider.of<List<FlashCard>>(context);

    return ListView.builder(
      itemCount: cards != null ? cards.length : 0,
      itemBuilder: (context, index) {
        return CardTile(card: cards[index]);
      },
    );
    // return new Column(
    // children: [
    // return new TinderSwapCard(
    //   swipeUp: false,
    //   swipeDown: false,
    //   orientation: AmassOrientation.TOP,
    //   totalNum: cardContent.length,
    //   stackNum: 3,
    //   swipeEdge: 4.0,
    //   maxWidth: MediaQuery.of(context).size.width * 0.9,
    //   maxHeight: MediaQuery.of(context).size.width * 0.9,
    //   minWidth: MediaQuery.of(context).size.width * 0.8,
    //   minHeight: MediaQuery.of(context).size.width * 0.8,
    //   cardBuilder: (context, index) => Card(
    //     child: Column(
    //       children: [
    //         Text('${index + 1}.' + '${cardContent[index]["question"]}'),
    //         Divider(),
    //         Text('${cardContent[index]["answer"]}'),
    //       ],
    //     ),
    //   ),
    //   cardController: controller = CardController(),
    //   swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
    //     /// Get swiping card's alignment
    //     if (align.x < 0) {
    //       debugPrint("Card swiped LEFT");
    //     } else if (align.x > 0) {
    //       debugPrint("Card swiped RIGHT");
    //     }
    //   },
    //   swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
    //     debugPrint(index.toString());
    //   },
    // );
    //     Column(children: [
    //       Text("Rate difficulty:"),
    //       Row(
    //         children: [
    //           OutlinedButton(
    //             onPressed: () => {debugPrint("very hard")},
    //             child: Text("Very Hard"),
    //           ),
    //           OutlinedButton(
    //             onPressed: () => {debugPrint("okay")},
    //             child: Text("Okay"),
    //           ),
    //           OutlinedButton(
    //             onPressed: () => {debugPrint("easy")},
    //             child: Text("Easy"),
    //           ),
    //         ],
    //       )
    //     ])
    //   ],
    // );
  }
}
