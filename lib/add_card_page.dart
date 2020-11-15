import 'package:flutter/material.dart';

class AddCard extends StatefulWidget {
  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  void addTag() {}

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
                          decoration: BoxDecoration(
                            color: Color(0xffEDEDED),
                            borderRadius: BorderRadius.all(
                              Radius.circular(25.0),
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
                        height: 150.0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xffEDEDED),
                            borderRadius: BorderRadius.all(
                              Radius.circular(25.0),
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
                        height: 150.0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xffEDEDED),
                            borderRadius: BorderRadius.all(
                              Radius.circular(25.0),
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
                  // SizedBox(
                  //   height: 10.0,
                  // ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 30.0,
                      ),
                      FlatButton(
                        onPressed: addTag,
                        height: 30.0,
                        child: Text(
                          "DBMS",
                          style: TextStyle(
                            color: Color(0xff1B689C),
                          ),
                        ),
                        color: Color(0xffA9DDED),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      FlatButton(
                        height: 30.0,
                        onPressed: addTag,
                        child: Text(
                          "Networks",
                          style: TextStyle(
                            color: Color(0xffA8317F),
                          ),
                        ),
                        color: Color(0xffEDA9D6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
                      onPressed: addTag,
                      height: 30.0,
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Color(0xff950F0F),
                        ),
                      ),
                      color: Color(0xffEDA9A9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    FlatButton(
                      height: 30.0,
                      onPressed: addTag,
                      child: Text(
                        "Done",
                        style: TextStyle(
                          color: Color(0xff08913F),
                        ),
                      ),
                      color: Color(0xffA9EDC4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    )));
  }
}
