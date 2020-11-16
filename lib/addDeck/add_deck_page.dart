import 'package:flutter/material.dart';
import 'package:flutterfiretest/addDeck/add_card.dart';
import 'package:flutterfiretest/database.dart';

class AddCard extends StatefulWidget {
  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  final TextEditingController deckNameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController frontController = TextEditingController();
  final TextEditingController backController = TextEditingController();

  String tag;

  List<bool> pressed = [false, false];

  void addTag(String tagName) {
    tag = tagName;
  }

  void cancel() {
    deckNameController.text = "";
    frontController.text = "";
    backController.text = "";
    descController.text = "";
    setState(() {
      pressed = [false, false];
    });
  }

  void post() async {
    String deckid = await DatabaseService()
        .addDeck(deckNameController.text, descController.text, tag);

    await DatabaseService()
        .addCard(deckid, frontController.text, backController.text);
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
                SingleChildScrollView(
                  child: Column(
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
                            height: 40.0,
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
                            height: 40.0,
                            child: Container(
                              // padding: EdgeInsets.all(5.0),
                              padding: EdgeInsets.only(
                                  top: 5.0,
                                  bottom: 5.0,
                                  right: 10.0,
                                  left: 10.0),
                              decoration: BoxDecoration(
                                color: Color(0xffEDEDED),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25.0),
                                ),
                              ),
                              child: TextField(
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
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 300.0,
                            height: 40.0,
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 5.0,
                                  bottom: 5.0,
                                  right: 10.0,
                                  left: 10.0),
                              decoration: BoxDecoration(
                                color: Color(0xffEDEDED),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25.0),
                                ),
                              ),
                              child: TextField(
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
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 50.0,
                            height: 20.0,
                            child: Center(
                              child: Text(
                                "Tags",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 30.0,
                          ),
                          FlatButton(
                            onPressed: () {
                              setState(() {
                                pressed[1] = false;
                                pressed[0] = !pressed[0];
                              });
                              addTag("DBMS");
                            },
                            child: Text(
                              "DBMS",
                              style: TextStyle(
                                color: Color(0xff1B689C),
                              ),
                            ),
                            height: 30.0,
                            color: Color(0xffA9DDED),
                            shape: RoundedRectangleBorder(
                              side: pressed[0]
                                  ? BorderSide(color: Color(0xff1B689C))
                                  : BorderSide(color: Color(0xffA9DDED)),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          FlatButton(
                            onPressed: () {
                              setState(() {
                                pressed[0] = false;
                                pressed[1] = !pressed[1];
                              });
                              addTag("Networks");
                            },
                            child: Text(
                              "Networks",
                              style: TextStyle(
                                color: Color(0xffA8317F),
                              ),
                            ),
                            height: 30.0,
                            color: Color(0xffEDA9D6),
                            shape: RoundedRectangleBorder(
                              side: pressed[1]
                                  ? BorderSide(color: Color(0xffA8317F))
                                  : BorderSide(color: Color(0xffEDA9D6)),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  child: CardForm(),
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
                            "Cancel",
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
                            "Done",
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
