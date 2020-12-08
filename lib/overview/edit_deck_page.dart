import 'package:flutter/material.dart';

class EditDeck extends StatefulWidget {
  Function setIndex;
  EditDeck(this.setIndex);
  @override
  _EditDeckState createState() => _EditDeckState(this.setIndex);
}

class _EditDeckState extends State<EditDeck> {
  Function setIndex;
  _EditDeckState(this.setIndex);
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
        child: Text("Edit deck"),
      ),
    );
  }
}
