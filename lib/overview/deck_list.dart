import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutterfiretest/database.dart';
import 'package:flutterfiretest/alert_dialog.dart';

class DeckList extends StatefulWidget {
  final Function setIndex;
  DeckList(this.setIndex);
  @override
  DeckListState createState() => DeckListState(this.setIndex);
}

class DeckListState extends State<DeckList> {
  Function setIndex;
  DeckListState(this.setIndex);

  TextEditingController searchController = new TextEditingController();

  List decks = [];
  List temp = [];

  static String deckid;

  static List<Color> colorArray = [
    Colors.deepPurpleAccent[400],
    Colors.cyanAccent[400],
    Colors.orangeAccent[400],
    Colors.greenAccent[400],
    Colors.pinkAccent[400],
    Colors.yellow[500],
    Colors.purpleAccent[700],
    Colors.redAccent[400],
  ];

  void getDeckDetails() async {
    temp = await DatabaseService().getDecks();
    setState(() {
      decks = temp;
    });
  }

  @override
  void initState() {
    super.initState();
    getDeckDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            //
            // Search Bar
            //
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 250.0,
                  height: 40.0,
                  child: Container(
                    padding:
                        EdgeInsets.only(bottom: 5.0, right: 10.0, left: 15.0),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(25)),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          decks = temp;
                          value = value.toLowerCase();
                          if (value == "") {
                            getDeckDetails();
                          } else {
                            decks = decks.where((deck) {
                              var title = deck['deckname'].toLowerCase();
                              var subtitle = deck['desc'].toLowerCase();
                              var tag = deck['tag'].toLowerCase();
                              return (title.contains(value) ||
                                  subtitle.contains(value) ||
                                  tag.contains(value));
                            }).toList();
                          }
                          print(decks);
                        });
                      },
                      controller: searchController,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          EvaIcons.searchOutline,
                        ),
                        hintText: "Search...",
                        hintStyle: TextStyle(
                          height: 1,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            //
            // List of Decks
            //
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: ListView.builder(
                itemCount: decks != null ? decks.length : 0,
                itemBuilder: (context, index) {
                  return Container(
                    child: Column(children: [
                      Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 5, bottom: 5, right: 15, left: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.all(
                                Radius.circular(25.0),
                              ),
                            ),
                            child: ListTile(
                              onTap: () {
                                print('Tapped ${decks[index]["deckid"]}');
                                setState(() {
                                  deckid = decks[index]["deckid"];
                                  // open the Game Page
                                  setIndex(4);
                                });
                              },
                              leading: CircleAvatar(
                                radius: 25.0,
                                //
                                // set color from colorArray
                                //
                                backgroundColor:
                                    colorArray[index % colorArray.length],
                                child: Text(decks[index]["tag"]),
                                foregroundColor: Colors.white,
                              ),
                              title: Text(
                                decks[index]["deckname"],
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                              subtitle: Text(
                                decks[index]["desc"] +
                                    " " +
                                    decks[index]["deckid"],
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                            ),
                          ),
                        ),
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            caption: 'Edit',
                            color: Colors.transparent,
                            foregroundColor: Colors.blue[600],
                            icon: EvaIcons.editOutline,
                            onTap: () {
                              print('Tapped to edit ${decks[index]["deckid"]}');
                              setState(() {
                                print(decks[index]["deckid"]);
                                deckid = decks[index]["deckid"];
                              });
                              setIndex(6);
                            },
                          ),
                          IconSlideAction(
                            caption: 'Delete',
                            color: Colors.transparent,
                            foregroundColor: Colors.red[600],
                            icon: EvaIcons.trashOutline,
                            onTap: () async {
                              print(
                                  'Tapped to delete ${decks[index]["deckid"]}');
                              final action = await Dialogs.yesAbort(
                                  context,
                                  "Delete Deck",
                                  "Are you sure?",
                                  "Delete",
                                  "No");

                              if (action == DialogAction.yes) {
                                await DatabaseService()
                                    .deleteDeck(decks[index]["deckid"]);
                              }
                              // refresh
                              getDeckDetails();
                            },
                          ),
                        ],
                      ),
                    ]),
                  );
                },
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
              ),
            ),
            Container(
                child: Center(
                    child: Text("Swipe left to edit or delete a deck.",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary)))),
          ],
        ),
      ),
    );
  }
}
