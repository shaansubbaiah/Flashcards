import 'package:flutter/material.dart';
import 'package:flutterfiretest/database.dart';
import 'package:flutterfiretest/overview/deck_tile.dart';

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

  List<dynamic> flashcards = [];
  int totCards = 0;

  Function setIndex;
  _GamePageState(this.setIndex);

  void switchPage({int pageNo}) {
    setState(() {
      if (index < totCards - 1) index += 1;
    });
  }

  @override
  void initState() {
    super.initState();
    deckid = DeckTileState.deckid;
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
                  child: Container(
                    child: FutureBuilder(
                      future: DatabaseService().getCardDetails(deckid),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          totCards = snapshot.data.length;
                          print('Total Cards: $totCards');
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: 500,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color:
                                  Theme.of(context).colorScheme.primaryVariant,
                              elevation: 10,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Q. " + snapshot.data[index]["front"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Divider(),
                                    Text(
                                      "A. " + snapshot.data[index]["back"],
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
                            setState(() => {index = 0})
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
