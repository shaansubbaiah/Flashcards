import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutterfiretest/overview/edit_card.dart';

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
  // final TextEditingController frontController = TextEditingController();
  // final TextEditingController backController = TextEditingController();
  final TextEditingController tagController = TextEditingController();

  final TextEditingController newFrontController = TextEditingController();
  final TextEditingController newBackController = TextEditingController();

  bool _deckNameValidate = true;
  bool _descValidate = true;
  // bool _frontValidate = true;
  // bool _backValidate = true;
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
        (_tagValidate || _customTagValidate)) {
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

  void updateCardList() async {
    List temp = await DatabaseService().getCardDetails(deckid);
    setState(() {
      cards = temp;
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
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            "Edit Deck",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                // Deck and card form
                //
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Center(
                                child: Text("Edit Deck details:",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)))),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 300.0,
                              height: 50.0,
                              child: TextFormField(
                                onChanged: (value) {
                                  if (value != "") {
                                    setState(() {
                                      _deckNameValidate = true;
                                    });
                                  }
                                },
                                controller: deckNameController,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryVariant,
                                ),
                                cursorColor: Theme.of(context)
                                    .colorScheme
                                    .primaryVariant,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: _deckNameValidate
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primaryVariant
                                          : Theme.of(context)
                                              .colorScheme
                                              .onError,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(40.0),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40.0)),
                                    borderSide: BorderSide(
                                      color: _deckNameValidate
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primaryVariant
                                          : Theme.of(context)
                                              .colorScheme
                                              .onError,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.0, horizontal: 10.0),
                                  labelText: "Deck name",
                                  labelStyle: TextStyle(
                                    color: _deckNameValidate
                                        ? Theme.of(context)
                                            .colorScheme
                                            .primaryVariant
                                        : Theme.of(context).colorScheme.onError,
                                  ),
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
                              height: 50.0,
                              child: TextFormField(
                                onChanged: (value) {
                                  if (value != "") {
                                    setState(() {
                                      _descValidate = true;
                                    });
                                  }
                                },
                                controller: descController,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryVariant,
                                ),
                                cursorColor: Theme.of(context)
                                    .colorScheme
                                    .primaryVariant,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: _descValidate
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primaryVariant
                                          : Theme.of(context)
                                              .colorScheme
                                              .onError,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(40.0),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40.0)),
                                    borderSide: BorderSide(
                                      color: _descValidate
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primaryVariant
                                          : Theme.of(context)
                                              .colorScheme
                                              .onError,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.0, horizontal: 10.0),
                                  labelText: "Description",
                                  labelStyle: TextStyle(
                                    color: _descValidate
                                        ? Theme.of(context)
                                            .colorScheme
                                            .primaryVariant
                                        : Theme.of(context).colorScheme.onError,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 300.0,
                              height: 50.0,
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
                                                  .primaryVariant,
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
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: _tagValidate
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primaryVariant
                                          : Theme.of(context)
                                              .colorScheme
                                              .onError,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(40.0),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40.0)),
                                    borderSide: BorderSide(
                                      color: _tagValidate
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primaryVariant
                                          : Theme.of(context)
                                              .colorScheme
                                              .onError,
                                    ),
                                  ),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20, 20, 10, 0),
                                  labelText: "Select Tag",
                                  labelStyle: TextStyle(
                                    color: _tagValidate
                                        ? Theme.of(context)
                                            .colorScheme
                                            .primaryVariant
                                        : Theme.of(context).colorScheme.onError,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: customTag ? 20.0 : 0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 300.0,
                              height: customTag ? 50.0 : 0.0,
                              child: customTag
                                  ? TextFormField(
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
                                            .primaryVariant,
                                      ),
                                      cursorColor: Theme.of(context)
                                          .colorScheme
                                          .primaryVariant,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: _customTagValidate
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primaryVariant
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .onError,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(40.0),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40.0)),
                                          borderSide: BorderSide(
                                            color: _customTagValidate
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primaryVariant
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .onError,
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 0.0, horizontal: 10.0),
                                        labelText: "Custom tag",
                                        labelStyle: TextStyle(
                                          color: _customTagValidate
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .primaryVariant
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .onError,
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        //
                        // Card form
                        //
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryVariant,
                                width: 1,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 270.0,
                                      height: 50.0,
                                      child: TextFormField(
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
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primaryVariant,
                                        ),
                                        cursorColor: Theme.of(context)
                                            .colorScheme
                                            .primaryVariant,
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: _newFrontValidate
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .primaryVariant
                                                  : Theme.of(context)
                                                      .colorScheme
                                                      .onError,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(40.0),
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(40.0)),
                                            borderSide: BorderSide(
                                              color: _newFrontValidate
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .primaryVariant
                                                  : Theme.of(context)
                                                      .colorScheme
                                                      .onError,
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 20.0),
                                          labelText: "Front",
                                          labelStyle: TextStyle(
                                            color: _newFrontValidate
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primaryVariant
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .onError,
                                          ),
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
                                      width: 270.0,
                                      height: 50.0,
                                      child: TextFormField(
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
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primaryVariant,
                                        ),
                                        cursorColor: Theme.of(context)
                                            .colorScheme
                                            .primaryVariant,
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: _newBackValidate
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .primaryVariant
                                                  : Theme.of(context)
                                                      .colorScheme
                                                      .onError,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(40.0),
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(40.0)),
                                            borderSide: BorderSide(
                                              color: _newBackValidate
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .primaryVariant
                                                  : Theme.of(context)
                                                      .colorScheme
                                                      .onError,
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 20.0),
                                          labelText: "Back",
                                          labelStyle: TextStyle(
                                            color: _newBackValidate
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primaryVariant
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .onError,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    FlatButton.icon(
                                      icon: Icon(
                                        EvaIcons.plusCircleOutline,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primaryVariant,
                                      ),
                                      onPressed: addNewCard,
                                      label: Text(
                                        "Add New Card",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primaryVariant,
                                        ),
                                      ),
                                      height: 30.0,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryVariant
                                          .withOpacity(0.3),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20.0,
                              child: _cardValidate
                                  ? null
                                  : Text(
                                      "A deck must contain atleast 1 card!",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onError),
                                    ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FlatButton.icon(
                              icon: Icon(
                                EvaIcons.editOutline,
                                color: Color(0xff08913F),
                              ),
                              onPressed: editDeck,
                              label: Text(
                                "Edit Deck",
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
                  ),
                ),
                //
                // List of cards created
                //
                (cards.length == 0)
                    ? Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                            child: Text("This deck has no cards yet!",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary))))
                    : Column(
                        children: [
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                  child: Text(
                                      '${cards.length} card(s) added to the deck:',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary)))),
                          Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: ListView.builder(
                              itemCount: cards.length,
                              itemBuilder: (_, index) {
                                return Slidable(
                                  actionPane: SlidableDrawerActionPane(),
                                  actionExtentRatio: 0.25,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: ListTile(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return EditCard(
                                                  cards[index]["front"],
                                                  cards[index]["back"],
                                                  cards[index]["cardId"],
                                                  deckid,
                                                  updateCardList);
                                            },
                                          );
                                        },
                                        title: Text(
                                          '${cards[index]["front"]}',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                        ),
                                        subtitle: Text(
                                          '${cards[index]["back"]}',
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
                                      caption: 'Delete',
                                      color: Colors.transparent,
                                      foregroundColor: Colors.red[600],
                                      icon: EvaIcons.trashOutline,
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
                                );
                              },
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                            ),
                          ),
                        ],
                      ),
                SizedBox(
                  height: 50.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
