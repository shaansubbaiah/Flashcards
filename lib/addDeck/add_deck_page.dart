import 'package:flutter/material.dart';
import 'package:flutterfiretest/database.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutterfiretest/alert_dialog.dart';

class AddCard extends StatefulWidget {
  Function setIndex;
  AddCard(this.setIndex);
  @override
  _AddCardState createState() => _AddCardState(this.setIndex);
}

class _AddCardState extends State<AddCard> {
  Function setIndex;
  _AddCardState(this.setIndex);
  final TextEditingController deckNameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController frontController = TextEditingController();
  final TextEditingController backController = TextEditingController();
  final TextEditingController tagController = TextEditingController();

  bool _deckNameValidate = true;
  bool _descValidate = true;
  bool _frontValidate = true;
  bool _backValidate = true;
  bool _cardValidate = true;
  bool _tagValidate = true;
  bool _customTagValidate = true;

  String tag, tagValue;

  var _tags = ["DBMS", "ADA", "CN", "OS", "New Tag"];

  bool customTag = false;

  List<Map<String, String>> cards = [];

  void addCard() {
    setState(() {
      _frontValidate = frontController.text.isEmpty ? false : true;
      _backValidate = backController.text.isEmpty ? false : true;
    });

    if (_backValidate && _frontValidate) {
      Map<String, String> card = {
        "front": frontController.text,
        "back": backController.text
      };

      setState(() {
        cards.add(card);
        frontController.text = "";
        backController.text = "";
        _cardValidate = true;
      });
    }
  }

  void cancel() {
    deckNameController.text = "";
    descController.text = "";
    tag = null;
    customTag = false;
    setState(() {
      cards.clear();
    });
  }

  void post() async {
    setState(() {
      _deckNameValidate = deckNameController.text.isEmpty ? false : true;
      _descValidate = descController.text.isEmpty ? false : true;
      _cardValidate = cards.isEmpty ? false : true;
      if (customTag) {
        _customTagValidate = tagController.text.isEmpty ? false : true;
      } else {
        if (tag == null) {
          _tagValidate = false;
        } else {
          _tagValidate = true;
        }
      }
    });

    if (customTag) {
      tagValue = tagController.text;
    } else {
      tagValue = tag;
    }

    if (_deckNameValidate &&
        _descValidate &&
        (_tagValidate || _customTagValidate) &&
        _cardValidate) {
      print(deckNameController.text);
      print(descController.text);
      print(tagValue);
      print(cards);

      final action = await Dialogs.yesAbort(
          context, "Post Deck", "Are you sure?", "Post", "No");

      if (action == DialogAction.yes) {
        String deckid = await DatabaseService()
            .addDeck(deckNameController.text, descController.text, tagValue);

        for (int i = 0; i < cards.length; i++) {
          await DatabaseService()
              .addCard(deckid, cards[i]["front"], cards[i]["back"]);
        }

        // Navigator.popAndPushNamed(context, "/home");
        this.setIndex(0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryVariant,
        title: Center(
          child: Text(
            "Add Flashcard",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: Center(
                            child: Text(
                              "Deck",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 250.0,
                          height: 50.0,
                          child: Container(
                            padding: EdgeInsets.only(
                                bottom: 5.0, right: 10.0, left: 15.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.all(
                                Radius.circular(25.0),
                              ),
                            ),
                            child: TextField(
                              onChanged: (value) {
                                if (value != "") {
                                  setState(() {
                                    _deckNameValidate = true;
                                  });
                                }
                              },
                              controller: deckNameController,
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                              cursorColor:
                                  Theme.of(context).colorScheme.onSecondary,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter deck name",
                                hintStyle: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 50.0, right: 10.0, top: 5.0),
                      child: _deckNameValidate
                          ? null
                          : Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Required",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onError),
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 300.0,
                          height: 50.0,
                          child: Container(
                            padding: EdgeInsets.only(
                                bottom: 5.0, right: 10.0, left: 15.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.all(
                                Radius.circular(25.0),
                              ),
                            ),
                            child: TextField(
                              onChanged: (value) {
                                if (value != "") {
                                  setState(() {
                                    _descValidate = true;
                                  });
                                }
                              },
                              controller: descController,
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                              cursorColor:
                                  Theme.of(context).colorScheme.onSecondary,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter description",
                                hintStyle: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 50.0, right: 10.0, top: 5.0),
                      child: _descValidate
                          ? null
                          : Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Required",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onError),
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 50.0,
                          height: 40.0,
                          child: Center(
                            child: Text(
                              "Tag",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        SizedBox(
                          width: 200.0,
                          height: 40.0,
                          child: DropdownButtonFormField(
                            items: _tags.map((String category) {
                              return new DropdownMenuItem(
                                  value: category,
                                  child: Row(
                                    children: [
                                      Text(
                                        category,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                        ),
                                      ),
                                    ],
                                  ));
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                tag = newValue;
                                _tagValidate = true;
                                if (tag == "New Tag") {
                                  customTag = true;
                                } else {
                                  customTag = false;
                                }
                              });
                            },
                            value: tag,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 20, 10, 0),
                              filled: true,
                              fillColor:
                                  Theme.of(context).colorScheme.secondary,
                              hintText: "Select Tag",
                              hintStyle: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 50.0, right: 10.0, top: 5.0),
                      child: _tagValidate
                          ? null
                          : Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Required",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onError),
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 70.0,
                        ),
                        SizedBox(
                          width: 200.0,
                          height: customTag ? 40.0 : 0.0,
                          child: Container(
                            padding: EdgeInsets.only(
                                bottom: 5.0, right: 10.0, left: 15.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.all(
                                Radius.circular(25.0),
                              ),
                            ),
                            child: customTag
                                ? TextField(
                                    onChanged: (value) {
                                      if (value != "") {
                                        setState(() {
                                          _customTagValidate = true;
                                        });
                                      }
                                    },
                                    controller: tagController,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    ),
                                    cursorColor: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Enter Custom Tag",
                                      hintStyle: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 50.0, right: 10.0, top: 5.0),
                      child: _customTagValidate
                          ? null
                          : Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Required",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onError),
                              ),
                            ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 300.0,
                      height: 60.0,
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: 5.0, right: 10.0, left: 15.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.all(
                            Radius.circular(25.0),
                          ),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            if (value != "") {
                              setState(() {
                                _frontValidate = true;
                              });
                            }
                          },
                          maxLines: 2,
                          controller: frontController,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                          cursorColor:
                              Theme.of(context).colorScheme.onSecondary,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Front",
                            hintStyle: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 50.0, right: 10.0, top: 5.0),
                  child: _frontValidate
                      ? null
                      : Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Required",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onError),
                          ),
                        ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 300.0,
                      height: 60.0,
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: 5.0, right: 10.0, left: 15.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.all(
                            Radius.circular(25.0),
                          ),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            if (value != "") {
                              setState(() {
                                _backValidate = true;
                              });
                            }
                          },
                          maxLines: 2,
                          controller: backController,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                          cursorColor:
                              Theme.of(context).colorScheme.onSecondary,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Back",
                            hintStyle: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 50.0, right: 10.0, top: 5.0),
                  child: _backValidate
                      ? null
                      : Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Required",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onError),
                          ),
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlatButton(
                      height: 30.0,
                      onPressed: addCard,
                      child: Text(
                        "Add card",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.0,
                  child: _cardValidate
                      ? null
                      : Text(
                          "Add one card",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onError),
                        ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FlatButton(
                          onPressed: cancel,
                          child: Text(
                            "Clear",
                            style: TextStyle(
                              color: Color(0xff950F0F),
                            ),
                          ),
                          height: 30.0,
                          color: Color(0xffEDA9A9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        FlatButton(
                          onPressed: post,
                          child: Text(
                            "Post",
                            style: TextStyle(
                              color: Color(0xff08913F),
                            ),
                          ),
                          height: 30.0,
                          color: Color(0xffA9EDC4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: cards.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 5.0),
                        child: Slidable(
                          actionPane: SlidableDrawerActionPane(),
                          actionExtentRatio: 0.25,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 5, bottom: 5, right: 15, left: 15),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25.0),
                                ),
                              ),
                              height: 70.0,
                              child: ListTile(
                                title: Text(
                                  '${cards[index]["front"]}',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
                                ),
                                subtitle: Text(
                                  '${cards[index]["back"]}',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary),
                                ),
                              ),
                            ),
                          ),
                          secondaryActions: <Widget>[
                            IconSlideAction(
                              caption: 'Delete',
                              color: Theme.of(context).colorScheme.onError,
                              icon: Icons.delete,
                              onTap: () {
                                setState(() {
                                  cards.removeAt(index);
                                  if (cards.isEmpty) {
                                    _cardValidate = false;
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    shrinkWrap: true,
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.end,
                //       children: [
                //         FlatButton(
                //           onPressed: cancel,
                //           child: Text(
                //             "Clear",
                //             style: TextStyle(
                //               color: Color(0xff950F0F),
                //             ),
                //           ),
                //           height: 30.0,
                //           color: Color(0xffEDA9A9),
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(25.0),
                //           ),
                //         ),
                //         SizedBox(
                //           width: 10.0,
                //         ),
                //         FlatButton(
                //           onPressed: post,
                //           child: Text(
                //             "Post",
                //             style: TextStyle(
                //               color: Color(0xff08913F),
                //             ),
                //           ),
                //           height: 30.0,
                //           color: Color(0xffA9EDC4),
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(25.0),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
