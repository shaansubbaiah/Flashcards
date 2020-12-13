import 'package:flutter/material.dart';
import 'package:flutterfiretest/database.dart';

class GamePage extends StatefulWidget {
  final Function setIndex;
  GamePage(this.setIndex);
  @override
  _GamePageState createState() => _GamePageState(this.setIndex);
}

class _GamePageState extends State<GamePage> {
  final currentDeck = "SchBjhHW0ixEmnIy2s6J";
  List<Widget> cardos = [];
  int index = 0;
  int stackIndex = 0;

  Function setIndex;
  _GamePageState(this.setIndex);

  void switchPage() {
    setState(() {
      if (stackIndex < cardos.length - 1) stackIndex += 1;
    });
  }

  void getFlashCardData() {
    List<Widget> tmp = [];
    DatabaseService()
        .getCardDetails(currentDeck)
        .then((value) => {
              print("Total cards:" + tmp.length.toString()),
              value.forEach((e) {
                print(e);
                index++;
                tmp.add(
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 500,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Theme.of(context).colorScheme.primaryVariant,
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              index.toString() + ". " + e["front"],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                              "A. " + e["back"],
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              })
            })
        .catchError((err) => {
              print(err),
            });
    setState(() {
      cardos = tmp;
    });
  }

  @override
  void initState() {
    super.initState();
    getFlashCardData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primaryVariant,
          title: Center(
            child: Text(
              "Game",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Theme.of(context).colorScheme.onPrimary,
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
                  child: IndexedStack(
                    index: stackIndex,
                    children: cardos,
                  ),
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    Wrap(
                      direction: Axis.horizontal,
                      spacing: 5,
                      children: [
                        OutlinedButton(
                          onPressed: () => {switchPage()},
                          child: Text("Next"),
                        ),
                        OutlinedButton(
                          onPressed: () => {
                            setState(() => {stackIndex = 0})
                          },
                          child: Text("Restart"),
                        ),
                      ],
                    ),
                    Text("Rate difficulty:"),
                    Wrap(
                      direction: Axis.horizontal,
                      spacing: 5,
                      children: [
                        OutlinedButton(
                          onPressed: () => {debugPrint("Very Spicy")},
                          child: Text("Very Hard"),
                        ),
                        OutlinedButton(
                          onPressed: () => {debugPrint("Hard")},
                          child: Text("Hard"),
                        ),
                        OutlinedButton(
                          onPressed: () => {debugPrint("Moderate")},
                          child: Text("Moderate"),
                        ),
                        OutlinedButton(
                          onPressed: () => {debugPrint("Easy")},
                          child: Text("Easy"),
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
