import 'package:flutter/material.dart';
import 'package:flutterfiretest/addDeck/card_data.dart';

typedef OnDelete();

class CardForm1 extends StatefulWidget {
  final CardData cardData;
  final state = _CardForm1State();
  final OnDelete onDelete;

  CardForm1({this.cardData, this.onDelete});

  @override
  _CardForm1State createState() => state;
}

class _CardForm1State extends State<CardForm1> {
  final TextEditingController frontController = TextEditingController();
  final TextEditingController backController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
              child: SizedBox(
                width: 250.0,
                height: 30.0,
                child: Center(
                  child: Text(
                    "Card Form",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.black,
              ),
              onPressed: widget.onDelete,
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: 300.0,
              height: 150.0,
              child: Container(
                padding: EdgeInsets.only(
                    top: 5.0, bottom: 5.0, right: 10.0, left: 10.0),
                decoration: BoxDecoration(
                  color: Color(0xffEDEDED),
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
                child: TextField(
                  controller: frontController,
                  style: TextStyle(
                    color: Color(0xff9E9D9D),
                  ),
                  cursorColor: Color(0xff9E9D9D),
                  maxLines: 6,
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
        SizedBox(
          height: 20.0,
        ),
        Row(
          children: [
            SizedBox(
              width: 300.0,
              height: 150.0,
              child: Container(
                padding: EdgeInsets.only(
                    top: 5.0, bottom: 5.0, right: 10.0, left: 10.0),
                decoration: BoxDecoration(
                  color: Color(0xffEDEDED),
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
                child: TextField(
                  controller: backController,
                  style: TextStyle(
                    color: Color(0xff9E9D9D),
                  ),
                  cursorColor: Color(0xff9E9D9D),
                  maxLines: 6,
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
      ],
    );
  }
}
