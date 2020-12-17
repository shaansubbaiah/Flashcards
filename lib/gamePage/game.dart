import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutterfiretest/database.dart';
import 'package:flutterfiretest/overview/deck_list.dart';

class GamePage extends StatefulWidget {
  final Function setIndex;
  GamePage(this.setIndex);
  @override
  _GamePageState createState() => _GamePageState(this.setIndex);
}

class _GamePageState extends State<GamePage> {
  List<Widget> cardos = [];
  int index = 0;
  String deckid;
  bool ansVisible = false;

  List<dynamic> flashcards = [];
  int totCards = 0;

  Function setIndex;
  _GamePageState(this.setIndex);

  void switchCard() {
    setState(() {
      if (index < totCards - 1) {
        toggleAnswer(hideAnswer: 0);
        index += 1;
      }
    });
  }

  void updateScore(int i, int diff) {
    // easy: 1, moderate: 2, hard: 3, v hard: 4
    print(flashcards[i]["score"].toString());
    if (diff == 1) {
    } else if (diff == 2) {
    } else if (diff == 3) {
    } else {}
  }

  void toggleAnswer({int hideAnswer}) {
    // if hideAnswer is provided, follow that, else toggle
    setState(() {
      if (hideAnswer != null) {
        if (hideAnswer == 1)
          ansVisible = true;
        else
          ansVisible = false;
      } else
        ansVisible = !ansVisible;
    });
  }

  @override
  void initState() {
    super.initState();
    deckid = DeckListState.deckid;
    print('deckid: $deckid');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Center(
            child: Text(
              "Game",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    child: FutureBuilder(
                      future: DatabaseService().getCardDetails(deckid),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          flashcards = snapshot.data;
                          totCards = flashcards.length;
                          print('Total Cards: $totCards');
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: 500,
                            child: InkWell(
                              onTap: () {
                                toggleAnswer();
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: Theme.of(context).colorScheme.surface,
                                elevation: 10,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Q. " + flashcards[index]["front"],
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      Divider(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                      Text(
                                        ansVisible
                                            ? "A. " + flashcards[index]["back"]
                                            : "Tap to view the answer",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Column(children: [
                              Icon(
                                EvaIcons.alertTriangleOutline,
                                color: Theme.of(context).colorScheme.onError,
                                size: 60,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Text('Error: ${snapshot.error}'),
                              )
                            ]),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    // Wrap(
                    //   direction: Axis.horizontal,
                    //   spacing: 5,
                    //   children: [
                    //     OutlinedButton(
                    //       onPressed: () => {switchCard()},
                    //       child: Text("Next"),
                    //     ),
                    //     OutlinedButton(
                    //       onPressed: () => {
                    //         setState(() => {index = 0})
                    //       },
                    //       child: Text("Restart"),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(height: 10),
                    Text(
                      "Rate difficulty:",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    SizedBox(height: 10),
                    Wrap(
                      direction: Axis.horizontal,
                      spacing: 5,
                      children: [
                        FlatButton(
                          color: Colors.red.withOpacity(0.2),
                          textColor: Colors.red,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                          ),
                          child: Text("Insane"),
                          onPressed: () => {
                            debugPrint("Insane"),
                            updateScore(index, 4),
                            switchCard(),
                          },
                        ),
                        FlatButton(
                          color: Colors.orange.withOpacity(0.2),
                          textColor: Colors.orange,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                          ),
                          child: Text("Hard"),
                          onPressed: () => {
                            debugPrint("Hard"),
                            updateScore(index, 3),
                            switchCard(),
                          },
                        ),
                        FlatButton(
                          color: Colors.yellow.withOpacity(0.2),
                          textColor: Colors.yellow[700],
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                          ),
                          child: Text("Moderate"),
                          onPressed: () => {
                            debugPrint("Moderate"),
                            updateScore(index, 2),
                            switchCard(),
                          },
                        ),
                        FlatButton(
                          color: Colors.green.withOpacity(0.2),
                          textColor: Colors.green,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                          ),
                          child: Text("Easy"),
                          onPressed: () => {
                            debugPrint("Easy"),
                            updateScore(index, 1),
                            switchCard(),
                          },
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
