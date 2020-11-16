import 'package:flutter/material.dart';
import 'package:flutterfiretest/addDeck/card_data.dart';
import 'package:flutterfiretest/addDeck/card_form.dart';

class CardForm extends StatefulWidget {
  @override
  _CardState createState() => _CardState();
}

class _CardState extends State<CardForm> {
  List<CardData> cards = [];

  final TextEditingController frontController = TextEditingController();
  final TextEditingController backController = TextEditingController();

  void onDelete(int index) {
    setState(() {
      cards.removeAt(index);
    });
  }

  void onAddCard() {
    setState(() {
      cards.add(CardData());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: cards.length == 0 ? 0.0 : 400.0,
          child: ListView.builder(
            itemCount: cards.length,
            itemBuilder: (_, i) => CardForm1(
              cardData: cards[i],
              onDelete: () => onDelete(i),
            ),
            shrinkWrap: true,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FlatButton(
              height: 30.0,
              onPressed: onAddCard,
              child: Text("Add card"),
            )
          ],
        ),
      ],
    );
  }
}
