import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../alert_dialog.dart';
import '../database.dart';
import 'deck_list.dart';

class EditDeck extends StatefulWidget {
  final Function setIndex;
  EditDeck(this.setIndex);
  @override
  _EditDeckState createState() => _EditDeckState(this.setIndex);
}

class _EditDeckState extends State<EditDeck> {
  final TextEditingController deckNameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController frontController = TextEditingController();
  final TextEditingController backController = TextEditingController();
  final TextEditingController tagController = TextEditingController();

  final TextEditingController newFrontController = TextEditingController();
  final TextEditingController newBackController = TextEditingController();

  bool _deckNameValidate = true;
  bool _descValidate = true;
  bool _frontValidate = true;
  bool _backValidate = true;
  bool _tagValidate = true;
  bool _customTagValidate = true;
  bool _newFrontValidate = true;
  bool _newBackValidate = true;
  bool _cardValidate = true;

  String tag, tagValue, deckid, cardId;

  var _tags = ["DBMS", "ADA", "CN", "OS", "New Tag"];

  bool customTag = false;

  List cards = [];
  List newCards = [];

  Function setIndex;
  _EditDeckState(this.setIndex);
  var deckDetails = {};

  void getData(String deckid) async {
    await DatabaseService()
        .getDeckDetails(deckid)
        .then((value) => {print(value), deckDetails = value})
        .catchError((e) => (print(e)));

    await DatabaseService()
        .getCardDetails(deckid)
        .then((value) => {cards = value, print(cards)})
        .catchError((e) => (print(e)));

    setState(() {
      deckNameController.text = deckDetails['deckname'];
      descController.text = deckDetails['desc'];
      for (int i = 0; i < _tags.length; i++) {
        if (_tags[i] == deckDetails['tag']) {
          tag = deckDetails['tag'];
          break;
        }
      }
      if (tag == null) {
        customTag = true;
        tag = _tags[_tags.length - 1];
        tagController.text = deckDetails['tag'];
      }
    });
  }

  void editDeck() async {
    setState(() {
      _deckNameValidate = deckNameController.text.isEmpty ? false : true;
      _descValidate = descController.text.isEmpty ? false : true;
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
      final action = await Dialogs.yesAbort(
          context, "Edit Deck", "Are you sure?", "Edit", "No");

      if (action == DialogAction.yes) {
        await DatabaseService()
            .editDeck(
                deckNameController.text, descController.text, tagValue, deckid)
            .then((value) {
          print(value);
        }).catchError((onError) {
          print(onError);
        });
        this.setIndex(0);
      }
    }
  }

  void editCard() async {
    _frontValidate = frontController.text.isEmpty ? false : true;
    _backValidate = backController.text.isEmpty ? false : true;

    if (_frontValidate && _backValidate) {
      await DatabaseService()
          .editCard(frontController.text, backController.text, cardId, deckid)
          .then((value) {
        print(value);
      }).catchError((onError) {
        print(onError);
      });
    }
  }

  void updateCardList() async {
    List temp = await DatabaseService().getCardDetails(deckid);
    setState(() {
      cards = temp;
      _cardValidate = cards.isEmpty ? false : true;
    });
  }

  void addNewCard() async {
    setState(() {
      _newFrontValidate = newFrontController.text.isEmpty ? false : true;
      _newBackValidate = newBackController.text.isEmpty ? false : true;
    });

    if (_newBackValidate && _newFrontValidate) {
      await DatabaseService()
          .addCard(deckid, newFrontController.text, newBackController.text);

      updateCardList();

      setState(() {
        // newCards.add(card);
        newFrontController.text = "";
        newBackController.text = "";
      });
    }
  }

  void deleteCard() async {
    await DatabaseService()
        .deleteOneCard(cardId)
        .then((value) => print(value))
        .catchError((onError) => print(onError));

    updateCardList();
  }

  @override
  void initState() {
    super.initState();
    deckid = DeckListState.deckid;
    getData(deckid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryVariant,
        title: Center(
          child: Text(
            "Edit Deck",
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
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                          cursorColor:
                              Theme.of(context).colorScheme.onSecondary,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter deck name",
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
                  child: _deckNameValidate
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
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                          cursorColor:
                              Theme.of(context).colorScheme.onSecondary,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter description",
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
                  child: _descValidate
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
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(20, 20, 10, 0),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.secondary,
                          hintText: "Select Tag",
                          hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 50.0, right: 10.0, top: 5.0),
                  child: _tagValidate
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
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                                cursorColor:
                                    Theme.of(context).colorScheme.onSecondary,
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
                  padding: EdgeInsets.only(left: 50.0, right: 10.0, top: 5.0),
                  child: _customTagValidate
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
                                _newFrontValidate = true;
                              });
                            }
                          },
                          maxLines: 2,
                          controller: newFrontController,
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
                  child: _newFrontValidate
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
                                _newBackValidate = true;
                              });
                            }
                          },
                          maxLines: 2,
                          controller: newBackController,
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
                  child: _newBackValidate
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
                      onPressed: addNewCard,
                      child: Text(
                        "Add new card",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlatButton(
                      onPressed: editDeck,
                      child: Text(
                        "Edit",
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
                                onTap: () {
                                  print(cards[index]["cardId"]);
                                  setState(() {
                                    frontController.text =
                                        cards[index]["front"];
                                    backController.text = cards[index]["back"];
                                    cardId = cards[index]["cardId"];
                                  });
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            'Edit Card',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary),
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .primaryVariant,
                                          content: SizedBox(
                                            height: 170.0,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 230.0,
                                                      height: 60.0,
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 5.0,
                                                                right: 10.0,
                                                                left: 15.0),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(
                                                                25.0),
                                                          ),
                                                        ),
                                                        child: TextField(
                                                          onChanged: (value) {
                                                            if (value != "") {
                                                              setState(() {
                                                                _frontValidate =
                                                                    true;
                                                              });
                                                            }
                                                          },
                                                          maxLines: 2,
                                                          controller:
                                                              frontController,
                                                          style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onSecondary,
                                                          ),
                                                          cursorColor:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .onSecondary,
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText: "Front",
                                                            hintStyle:
                                                                TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .onSecondary,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: _frontValidate
                                                      ? null
                                                      : 15,
                                                  // padding: EdgeInsets.only(
                                                  //     left: 50.0,
                                                  //     right: 10.0,
                                                  //     top: 5.0),
                                                  child: _frontValidate
                                                      ? null
                                                      : Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Text(
                                                            "Required",
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onError),
                                                          ),
                                                        ),
                                                ),
                                                // SizedBox(
                                                //   height: 20.0,
                                                // ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 230.0,
                                                      height: 60.0,
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 5.0,
                                                                right: 10.0,
                                                                left: 15.0),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(
                                                                25.0),
                                                          ),
                                                        ),
                                                        child: TextField(
                                                          onChanged: (value) {
                                                            if (value != "") {
                                                              setState(() {
                                                                _backValidate =
                                                                    true;
                                                              });
                                                            }
                                                          },
                                                          maxLines: 2,
                                                          controller:
                                                              backController,
                                                          style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onSecondary,
                                                          ),
                                                          cursorColor:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .onSecondary,
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText: "Back",
                                                            hintStyle:
                                                                TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .onSecondary,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height:
                                                      _backValidate ? null : 15,
                                                  // padding: EdgeInsets.only(
                                                  //     left: 50.0,
                                                  //     right: 10.0,
                                                  //     top: 5.0),
                                                  child: _backValidate
                                                      ? null
                                                      : Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Text(
                                                            "Required",
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onError),
                                                          ),
                                                        ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Cancel"),
                                            ),
                                            RaisedButton(
                                              onPressed: () {
                                                setState(() {
                                                  _frontValidate =
                                                      frontController
                                                              .text.isEmpty
                                                          ? false
                                                          : true;
                                                  _backValidate = backController
                                                          .text.isEmpty
                                                      ? false
                                                      : true;

                                                  if (_frontValidate &&
                                                      _backValidate) {
                                                    editCard();
                                                    Navigator.of(context).pop();
                                                    // updateCardList();
                                                  }
                                                });
                                                updateCardList();
                                              },
                                              child: Text("Update"),
                                            ),
                                          ],
                                        );
                                      });
                                },
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
                              color: Colors.transparent,
                              foregroundColor: Colors.red[600],
                              icon: EvaIcons.trashOutline,
                              onTap: () {
                                cardId = cards[index]['cardId'];
                                deleteCard();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
