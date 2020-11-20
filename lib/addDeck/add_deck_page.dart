import 'package:flutter/material.dart';
import 'package:flutterfiretest/database.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutterfiretest/alert_dialog.dart';

class AddCard extends StatefulWidget {
  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
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

        Navigator.popAndPushNamed(context, "/home");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 30.0,
                    ),
                    SizedBox(
                      child: Text(
                        "Add Flash Card",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
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
                              color: Color(0xffEDEDED),
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
                                color: Color(0xff9E9D9D),
                              ),
                              cursorColor: Color(0xff9E9D9D),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter deck name",
                                hintStyle: TextStyle(
                                  color: Color(0xff9E9D9D),
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
                                style: TextStyle(color: Colors.red),
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
                              color: Color(0xffEDEDED),
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
                                color: Color(0xff9E9D9D),
                              ),
                              cursorColor: Color(0xff9E9D9D),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter description",
                                hintStyle: TextStyle(
                                  color: Color(0xff9E9D9D),
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
                                style: TextStyle(color: Colors.red),
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
                                          color: Color(0xff9E9D9D),
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
                                  color: Color(0xffEDEDED),
                                ),
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 20, 10, 0),
                              filled: true,
                              fillColor: Color(0xffEDEDED),
                              hintText: "Select Tag",
                              hintStyle: TextStyle(
                                color: Color(0xff9E9D9D),
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
                                style: TextStyle(color: Colors.red),
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
                              color: Color(0xffEDEDED),
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
                                      color: Color(0xff9E9D9D),
                                    ),
                                    cursorColor: Color(0xff9E9D9D),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Enter Custom Tag",
                                      hintStyle: TextStyle(
                                        color: Color(0xff9E9D9D),
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
                                style: TextStyle(color: Colors.red),
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
                          color: Color(0xffEDEDED),
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
                            color: Color(0xff9E9D9D),
                          ),
                          cursorColor: Color(0xff9E9D9D),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Front",
                            hintStyle: TextStyle(
                              color: Color(0xff9E9D9D),
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
                            style: TextStyle(color: Colors.red),
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
                          color: Color(0xffEDEDED),
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
                            color: Color(0xff9E9D9D),
                          ),
                          cursorColor: Color(0xff9E9D9D),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Back",
                            hintStyle: TextStyle(
                              color: Color(0xff9E9D9D),
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
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlatButton(
                      height: 30.0,
                      onPressed: addCard,
                      child: Text("Add card"),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.0,
                  child: _cardValidate
                      ? null
                      : Text(
                          "Add one card",
                          style: TextStyle(color: Colors.red),
                        ),
                ),
                ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: cards.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        child: Container(
                          height: 70.0,
                          color: Colors.white,
                          child: ListTile(
                            title: Text('${cards[index]["front"]}'),
                            subtitle: Text('${cards[index]["back"]}'),
                          ),
                        ),
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            caption: 'Delete',
                            color: Colors.red,
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
                SizedBox(
                  height: 40.0,
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
