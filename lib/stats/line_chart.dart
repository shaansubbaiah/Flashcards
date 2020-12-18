import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutterfiretest/database.dart';

class LineChart extends StatefulWidget {
  @override
  _LineChartState createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {
  String name;
  Color avatarColor;

  List<charts.Series<Level, int>> seriesLineData;

  List temp;

  Future<List> getAvg() async {
    temp = await DatabaseService().getAvgScore();
    for (int i = 0; i < temp.length; i++) {
      temp[i] = temp[i].ceil();
    }
    print(temp);
    return temp;
  }

  void generateData() {
    // var lineData = [];

    // for (int i = 0; i < temp.length; i++) {
    //   lineData.add(new Level(i, temp[i]));
    // }
    // var lineData = [
    //   new Level(0, temp[0]),
    //   new Level(1, temp[1]),
    //   new Level(2, temp[2]),
    //   new Level(3, temp[3]),
    //   new Level(4, temp[4]),
    //   new Level(5, temp[5]),
    //   new Level(6, temp[6]),
    //   new Level(7, temp[7]),
    //   new Level(8, temp[8]),
    //   new Level(9, temp[9]),
    //   new Level(10, temp[10]),
    //   new Level(11, temp[11]),
    //   new Level(12, temp[12]),
    //   new Level(13, temp[13]),
    //   new Level(14, temp[14]),
    // ];

    // static data
    var lineData = [
      new Level(0, 0),
      new Level(1, 3),
      new Level(2, 1),
      new Level(3, 2),
      new Level(4, 3),
      new Level(5, 2),
      new Level(6, 4),
      new Level(7, 2),
      new Level(8, 3),
      new Level(9, 1),
      new Level(10, 2),
      new Level(11, 2),
      new Level(12, 4),
      new Level(13, 1),
      new Level(14, 2),
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
    // generateData();
    avatarColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: getAvg(),
              builder: (context, _) {
                if (temp != null) {
                  generateData();
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("15 days average score",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary)),
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
                                    primaryMeasureAxis:
                                        new charts.NumericAxisSpec(
                                      renderSpec: new charts.NoneRenderSpec(),
                                    ),
                                    defaultRenderer:
                                        new charts.LineRendererConfig(
                                      includeArea: false,
                                      includePoints: false,
                                    ),
                                    domainAxis: new charts.NumericAxisSpec(
                                        renderSpec:
                                            new charts.NoneRenderSpec()),
                                    animate: true,
                                    animationDuration: Duration(seconds: 2),
                                    // behaviors: [
                                    //   new charts.ChartTitle('Level',
                                    //       behaviorPosition:
                                    //           charts.BehaviorPosition.bottom,
                                    //       titleOutsideJustification: charts
                                    //           .OutsideJustification.middleDrawArea),
                                    //   new charts.ChartTitle('No of questions',
                                    //       behaviorPosition:
                                    //           charts.BehaviorPosition.start,
                                    //       titleOutsideJustification: charts
                                    //           .OutsideJustification.middleDrawArea),
                                    // ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              }),
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
