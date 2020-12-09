import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String btnText = "Total Cards";
  String name;
  Color avatarColor;

  void totalText() {
    setState(() {
      if (btnText == "Total Cards") {
        btnText = "20";
      } else {
        btnText = "Total Cards";
      }
    });
  }

  List<charts.Series<Level, String>> seriesPieData;

  void generateData() {
    var pieData = [
      new Level("Easy", 10, Color(0xff5DFA00)),
      new Level("Moderate", 8, Color(0xffB7FA00)),
      new Level("Hard", 4, Color(0xffFF7E00)),
      new Level("Very Hard", 6, Color(0xffFF2C00)),
    ];

    seriesPieData.add(charts.Series(
      data: pieData,
      domainFn: (Level level, _) => level.level,
      measureFn: (Level level, _) => level.levelValue,
      colorFn: (Level level, _) =>
          charts.ColorUtil.fromDartColor(level.colorval),
      id: "Stats",
      labelAccessorFn: (Level row, _) => '${row.levelValue}',
    ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final User user = FirebaseAuth.instance.currentUser;
    name = user.email;
    seriesPieData = List<charts.Series<Level, String>>();
    generateData();
    avatarColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryVariant,
        title: Center(
          child: Text(
            "Profile",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Theme.of(context).colorScheme.onPrimary,
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
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: CircleAvatar(
                        radius: 40.0,
                        backgroundColor: avatarColor,
                        child: Text(
                          name[0].toUpperCase(),
                          style: TextStyle(
                            fontSize: 40,
                          ),
                        ),
                        foregroundColor: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 0, bottom: 5),
                      child: Text(
                        name.substring(0, name.indexOf('@')),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Stats",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FlatButton(
                            onPressed: totalText,
                            child: Text(btnText),
                            height: 30.0,
                            color: Color(0xffEDEDED),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          SizedBox(
                            height: 400,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: charts.PieChart(
                                seriesPieData,
                                animate: true,
                                animationDuration: Duration(seconds: 2),
                                behaviors: [
                                  new charts.DatumLegend(
                                    outsideJustification:
                                        charts.OutsideJustification.endDrawArea,
                                    horizontalFirst: false,
                                    desiredMaxRows: 2,
                                    cellPadding: new EdgeInsets.only(
                                        right: 4.0, bottom: 4.0),
                                    entryTextStyle: charts.TextStyleSpec(
                                        color: charts.MaterialPalette.purple
                                            .shadeDefault,
                                        fontSize: 11),
                                  ),
                                ],
                                defaultRenderer: new charts.ArcRendererConfig(
                                    arcWidth: 100,
                                    arcRendererDecorators: [
                                      new charts.ArcLabelDecorator(
                                          labelPosition:
                                              charts.ArcLabelPosition.inside)
                                    ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Level {
  String level;
  int levelValue;
  Color colorval;

  Level(this.level, this.levelValue, this.colorval);
}
