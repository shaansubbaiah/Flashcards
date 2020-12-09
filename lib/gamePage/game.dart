import 'package:flutter/material.dart';
import 'package:flutterfiretest/database.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final currentDeck = "SchBjhHW0ixEmnIy2s6J";
  List<Widget> cardos = [];
  int index = 0;
  int stackIndex = 0;

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
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(color: Colors.amber),
                    child: Column(
                      children: [
                        Text(index.toString() + ". " + e["front"]),
                        Text("A. " + e["back"]),
                      ],
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
                child: IndexedStack(
                  index: stackIndex,
                  children: cardos,
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
