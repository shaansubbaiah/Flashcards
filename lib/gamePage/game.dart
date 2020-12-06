import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:flutterfiretest/database.dart';
import 'package:carousel_slider/carousel_slider.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final currentDeck = "v4VFWkP6JQGAfuCPhBf8";
  var flashcards;

  @override
  Widget build(BuildContext context) {
    // final flashcards = Provider.of<List<FlashCard>>(context);
    DatabaseService()
        .getCardDetails(currentDeck)
        .then((value) => {
              print(value),
              flashcards = value,
              print("Total cards:" + flashcards.length.toString()),
            })
        .catchError((err) => {
              print(err),
              flashcards = [],
            });

    CarouselController buttonCarouselController = CarouselController();

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
      child: Column(children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 400.0,
            enableInfiniteScroll: false,
            // to prevent the user from swiping the cards
            scrollPhysics: NeverScrollableScrollPhysics(),
          ),
          carouselController: buttonCarouselController,
          items: [1, 2, 3, 4, 5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(color: Colors.amber),
                    child: Column(
                      children: [
                        Text(
                          'Q$i',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text("What, Why, When?"),
                      ],
                    ));
              },
            );
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlineButton(
              onPressed: () => buttonCarouselController.jumpToPage(0),
              child: Text('Restart'),
            ),
            OutlineButton(
              onPressed: () => buttonCarouselController.nextPage(
                  duration: Duration(milliseconds: 300), curve: Curves.linear),
              child: Text('Next'),
            ),
          ],
        ),
        Text("Rate difficulty:"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () => {debugPrint("Very Spicy")},
              child: Text("Very Hard"),
            ),
            OutlinedButton(
              onPressed: () => {debugPrint("Hard")},
              child: Text("Hard"),
            ),
            OutlinedButton(
              onPressed: () => {debugPrint("Moderate")},
              child: Text("Moderate"),
            ),
            OutlinedButton(
              onPressed: () => {debugPrint("Easy")},
              child: Text("Easy"),
            ),
          ],
        )
      ]),
    );
    //   ],
    // );
  }
}
