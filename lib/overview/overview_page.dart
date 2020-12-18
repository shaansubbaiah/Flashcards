import 'package:flutter/material.dart';
import 'package:flutterfiretest/overview/deck_list.dart';

class Overview extends StatefulWidget {
  final Function setIndex;
  Overview(this.setIndex);
  @override
  _OverviewState createState() => _OverviewState(this.setIndex);
}

class _OverviewState extends State<Overview> {
  Function setIndex;
  _OverviewState(this.setIndex);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            "Your Decks",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
      body: DeckList(this.setIndex),
    );
  }
}
