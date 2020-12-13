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
  int stackIndex = -1;
  String deckid;

  Function setIndex;
  _GamePageState(this.setIndex);

  void switchPage({int pageNo}) {
    setState(() {
      // switch to a specific page
      if (pageNo != null) {
        print('switching to page $pageNo');
        stackIndex = pageNo;
      }
      // add a proper condition here...
      // by default, switch to the next page
      else if (stackIndex < cardos.length - 1) {
        stackIndex += 1;
      }
    });
  }

  void getFlashCardData(String deckid) async {
    List<Widget> tmp = [];
    await DatabaseService()
        .getCardDetails(deckid)
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
    deckid = DeckTileState.deckid;
    print('Now playing deck: $deckid');
    getFlashCardData(deckid);
    // Start the game at the first card
    switchPage(pageNo: 0);
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
