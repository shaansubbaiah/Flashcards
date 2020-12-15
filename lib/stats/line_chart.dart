import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class LineChart extends StatefulWidget {
  @override
  _LineChartState createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {
  String name;
  Color avatarColor;

  List<charts.Series<Level, int>> seriesLineData;

  void generateData() {
    var lineData = [
      new Level(0, 2),
      new Level(1, 4),
      new Level(2, 1),
      new Level(3, 3),
    ];

    seriesLineData.add(
      charts.Series(
        id: "Stats",
        data: lineData,
        domainFn: (Level level, _) => level.level,
        measureFn: (Level level, _) => level.levelValue,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    seriesLineData = List<charts.Series<Level, int>>();
    generateData();
    avatarColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 300,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: charts.LineChart(
                            seriesLineData,
                            defaultRenderer: new charts.LineRendererConfig(
                                includeArea: true, stacked: false),
                            animate: true,
                            animationDuration: Duration(seconds: 2),
                            behaviors: [
                              new charts.ChartTitle('Level',
                                  behaviorPosition:
                                      charts.BehaviorPosition.bottom,
                                  titleOutsideJustification: charts
                                      .OutsideJustification.middleDrawArea),
                              new charts.ChartTitle('No of questions',
                                  behaviorPosition:
                                      charts.BehaviorPosition.start,
                                  titleOutsideJustification: charts
                                      .OutsideJustification.middleDrawArea),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Level {
  int level;
  int levelValue;

  Level(this.level, this.levelValue);
}
