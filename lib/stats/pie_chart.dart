import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutterfiretest/database.dart';

class PieChart extends StatefulWidget {
  @override
  _PieChartState createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  List<charts.Series<Level, String>> seriesPieData;

  void generateData() async {
    // List scoreCount = await DatabaseService().getScoreCount();
    // print(scoreCount);
    var pieData = [
      new Level("Easy", 10, Colors.green),
      new Level("Moderate", 8, Colors.yellow),
      new Level("Hard", 4, Colors.orange),
      new Level("Insane", 6, Colors.red),
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
    super.initState();
    seriesPieData = List<charts.Series<Level, String>>();
    generateData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 300,
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
                        cellPadding:
                            new EdgeInsets.only(right: 4.0, bottom: 4.0),
                        entryTextStyle: charts.TextStyleSpec(
                            color: charts.MaterialPalette.purple.shadeDefault,
                            fontSize: 11),
                      ),
                    ],
                    defaultRenderer: new charts.ArcRendererConfig(
                        arcWidth: 75,
                        arcRendererDecorators: [
                          new charts.ArcLabelDecorator(
                              labelPosition: charts.ArcLabelPosition.inside)
                        ]),
                  ),
                ),
              ),
            ],
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
