import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:flutterfiretest/database.dart';
import 'package:carousel_slider/carousel_slider.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final currentDeck = "SchBjhHW0ixEmnIy2s6J";
  var flashcards = [];
  var index = 1;

  @override
  Widget build(BuildContext context) {
    DatabaseService()
        .getCardDetails(currentDeck)
        .then((value) => {
              // print(value[0]["front"]),
              flashcards = value,
              print("Total cards:" + flashcards.length.toString()),
              flashcards.forEach((element) {
                print(element);
              })
            })
        .catchError((err) => {
              print(err),
              flashcards = [
                {"front": "Error", "back": "Error2"}
              ],
            });

    CarouselController buttonCarouselController = CarouselController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            "Game",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Column(children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 400.0,
            enableInfiniteScroll: false,
            // to prevent the user from swiping the cards
            scrollPhysics: NeverScrollableScrollPhysics(),
          ),
          carouselController: buttonCarouselController,
          // items: flashCardWidgetList(),
          items: flashcards.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(color: Colors.amber),
                    child: Column(
                      children: [
                        Text(
                          'Q$index.' + " " + i["front"],
                        ),
                        Text(
                          i["back"],
                        )
                      ],
                    ));
              },
            );
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () => buttonCarouselController.animateToPage(0,
                  duration: Duration(milliseconds: 300), curve: Curves.linear),
              child: Text('Restart'),
            ),
            OutlinedButton(
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
  }
}
