import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutterfiretest/database.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutterfiretest/alert_dialog.dart';

class AddCard extends StatefulWidget {
  final Function setIndex;
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
    frontController.text = "";
    backController.text = "";
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
        // go to the home page
        this.setIndex(0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            "Create a Deck",
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
                                  child: Text("Specify Deck details:",
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
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  cursorColor:
                                      Theme.of(context).colorScheme.primary,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: _deckNameValidate
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
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
                                        color: _deckNameValidate
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Theme.of(context)
                                                .colorScheme
                                                .onError,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 0.0, horizontal: 10.0),
                                    labelText: "Enter deck name",
                                    labelStyle: TextStyle(
                                      color: _deckNameValidate
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
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
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  cursorColor:
                                      Theme.of(context).colorScheme.primary,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: _descValidate
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
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
                                        color: _descValidate
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Theme.of(context)
                                                .colorScheme
                                                .onError,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 0.0, horizontal: 10.0),
                                    labelText: "Enter description",
                                    labelStyle: TextStyle(
                                      color: _descValidate
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
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
                                                    .primary,
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
                                                .primary
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
                                        color: _tagValidate
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Theme.of(context)
                                                .colorScheme
                                                .onError,
                                      ),
                                    ),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 20, 10, 0),
                                    filled: true,
                                    fillColor: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    labelText: "Select Tag",
                                    labelStyle: TextStyle(
                                      color: _tagValidate
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
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
                                              .primary,
                                        ),
                                        cursorColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: _customTagValidate
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .primary
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
                                                      .primary
                                                  : Theme.of(context)
                                                      .colorScheme
                                                      .onError,
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 0.0, horizontal: 10.0),
                                          labelText: "Enter custom tag",
                                          labelStyle: TextStyle(
                                            color: _customTagValidate
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primary
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
                                  width: 2,
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
                                                _frontValidate = true;
                                              });
                                            }
                                          },
                                          maxLines: 2,
                                          controller: frontController,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          cursorColor: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: _frontValidate
                                                    ? Theme.of(context)
                                                        .colorScheme
                                                        .primary
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
                                                color: _frontValidate
                                                    ? Theme.of(context)
                                                        .colorScheme
                                                        .primary
                                                    : Theme.of(context)
                                                        .colorScheme
                                                        .onError,
                                              ),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 10.0,
                                                    horizontal: 20.0),
                                            labelText: "Front",
                                            labelStyle: TextStyle(
                                              color: _frontValidate
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .primary
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
                                                _backValidate = true;
                                              });
                                            }
                                          },
                                          maxLines: 2,
                                          controller: backController,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          cursorColor: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: _backValidate
                                                    ? Theme.of(context)
                                                        .colorScheme
                                                        .primary
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
                                                color: _backValidate
                                                    ? Theme.of(context)
                                                        .colorScheme
                                                        .primary
                                                    : Theme.of(context)
                                                        .colorScheme
                                                        .onError,
                                              ),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 10.0,
                                                    horizontal: 20.0),
                                            labelText: "Back",
                                            labelStyle: TextStyle(
                                              color: _backValidate
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .primary
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
                                        onPressed: addCard,
                                        label: Text(
                                          "Add Card",
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
                                  EvaIcons.closeOutline,
                                  color: Color(0xff950F0F),
                                ),
                                onPressed: cancel,
                                label: Text(
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
                              FlatButton.icon(
                                icon: Icon(
                                  EvaIcons.checkmarkOutline,
                                  color: Color(0xff08913F),
                                ),
                                onPressed: post,
                                label: Text(
                                  "Create Deck",
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
                    )),
                //
                // List of cards created
                //
                Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                        child: Text("Cards added to the deck:",
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.primary)))),
                Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: ListView.builder(
                    // padding: const EdgeInsets.all(8),
                    itemCount: cards.length,
                    itemBuilder: (_, index) {
                      return Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(25)),
                          child: ListTile(
                            title: Text(
                              '${cards[index]["front"]}',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            subtitle: Text(
                              '${cards[index]["back"]}',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
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
