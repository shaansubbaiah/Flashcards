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

  int loop = 0; // loop type
  int nextType = 1; // normal: 0 insanse: 1 hard: 2 moderate: 3
  int normal = 0;

  bool gameOver = false;

  void switchCard() {
    // setState(() {
    if (index < totCards - 1) {
      toggleAnswer(hideAnswer: 0);
      // index += 1;
    }
    // });
    // print(flashcards);
  }

  int next(int level) {
    // for circular loop
    for (int i = index + 1; i < (flashcards.length + index); i++) {
      if (flashcards[i % flashcards.length]['score'] == level) {
        return (i % flashcards.length);
      }
    }
    return null;
  }

  // loop 0: normal increment -> insane
  // loop 1: normal increment -> insane -> hard
  // loop 2: normal increment -> insane ->hard -> moderate

  // nextType 0: normal
  // nextType 1: insane
  // nextType 2: hard

  void nextIndex() {
    int tempIndex;
    while (tempIndex == null) {
      // check for easy question
      if (nextType == 0 &&
          flashcards[(normal + 1) % flashcards.length]['score'] == 4) {
        normal = (normal + 1) % flashcards.length;
        continue;
      }
      if (loop == 0) {
        print("Currently in loop 0");
        if (nextType == 1) {
          tempIndex = next(1);
          print("Next insane at");
          print(tempIndex);
          nextType = 0;
        } else {
          tempIndex = (normal + 1) % flashcards.length;
          normal = tempIndex;
          loop = 1;
          print("Next normal at");
          print(tempIndex);
        }
      } else if (loop == 1) {
        print("Currently in loop 1");
        if (nextType == 0) {
          tempIndex = (normal + 1) % flashcards.length;
          normal = tempIndex;
          print("Next normal at");
          print(tempIndex);
          nextType = 1;
        } else if (nextType == 1) {
          tempIndex = next(1);
          nextType = 2;
          print("Next insane at");
          print(tempIndex);
        } else {
          tempIndex = next(2);
          nextType = 0;
          loop = 2;
          print("Next hard at");
          print(tempIndex);
        }
      } else if (loop == 2) {
        print("Currently in loop 2");
        if (nextType == 0) {
          tempIndex = (normal + 1) % flashcards.length;
          normal = tempIndex;
          nextType = 1;
          print("Next normal at");
          print(tempIndex);
        } else if (nextType == 1) {
          tempIndex = next(1);
          print("Next insane at");
          print(tempIndex);
          nextType = 2;
        } else if (nextType == 2) {
          tempIndex = next(2);
          nextType = 3;
          print("Next hard at");
          print(tempIndex);
        } else {
          tempIndex = next(3);
          nextType = 0;
          print("Next moderate at");
          print(tempIndex);
        }
        loop = 0;
      }
    }

    print("Score");
    print(flashcards[tempIndex]['score']);

    setState(() {
      if (!mounted) return;
      index = tempIndex;
    });
  }

  bool gameOverCheck() {
    for (int i = 0; i < flashcards.length; i++) {
      if (flashcards[i]['score'] != 4) {
        return false;
      }
    }
    return true;
  }

  void updateScore(int i, int diff) async {
    // easy: 4, moderate: 3 hard: 2, v hard: 1
    // print(flashcards[i]["score"].toString());

    flashcards[i]["score"] = diff;

    // update score in database
    await DatabaseService().updateScore(flashcards[i]["cardId"], diff);

    if (gameOverCheck()) {
      setState(() {
        gameOver = true;
      });
      print("over");
    } else {
      nextIndex();
    }
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
                    child: gameOver
                        ? Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Theme.of(context).colorScheme.surface,
                            elevation: 10,
                            child: Column(
                              children: [
                                Text("Over"),
                                RaisedButton(
                                  onPressed: () async {
                                    DatabaseService().resetDeck(deckid);
                                    flashcards = await DatabaseService()
                                        .getCardDetails(deckid);
                                    setState(() {
                                      gameOver = false;
                                    });
                                    print("reset deck");
                                  },
                                  child: Text("reset deck"),
                                ),
                              ],
                            ),
                          )
                        : FutureBuilder(
                            future: DatabaseService().getCardDetails(deckid),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                flashcards = snapshot.data;
                                totCards = flashcards.length;
                                print(flashcards);
                                print('Total Cards: $totCards');
                                if (!gameOverCheck()) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 500,
                                    child: InkWell(
                                      onTap: () {
                                        toggleAnswer();
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        elevation: 10,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Q. " +
                                                    flashcards[index]["front"],
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
                                                    ? "A. " +
                                                        flashcards[index]
                                                            ["back"]
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
                                } else {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    elevation: 10,
                                    child: Column(
                                      children: [
                                        Text("All easy"),
                                        RaisedButton(
                                          onPressed: () async {
                                            DatabaseService().resetDeck(deckid);
                                            flashcards = await DatabaseService()
                                                .getCardDetails(deckid);
                                            setState(() {
                                              gameOver = false;
                                            });
                                            print("reset deck");
                                          },
                                          child: Text("reset deck"),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Column(children: [
                                    Icon(
                                      EvaIcons.alertTriangleOutline,
                                      color:
                                          Theme.of(context).colorScheme.onError,
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
                            updateScore(index, 1),
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
                            updateScore(index, 2),
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
                            updateScore(index, 3),
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
                            updateScore(index, 4),
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
