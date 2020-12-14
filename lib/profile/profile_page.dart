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

  

  List<charts.Series<Level, int>> seriesLineData;

  void generateData() {
    

    var lineData=[
      new Level(0,2),
      new Level(1, 4),
      new Level(2, 1),
      new Level(3,3),
    ];

    

    seriesLineData.add(charts.Series(
        id: "Stats",
        data: lineData,
        domainFn: (Level level, _) => level.level,
        measureFn: (Level level, _) => level.levelValue,
      ),
    );
    // seriesLineData.add(charts.Series(
    //     id: "Stats",
    //     data: lineData1,
    //     domainFn: (Level level, _) => level.level,
    //     measureFn: (Level level, _) => level.levelValue,
    //   ),
    // );
  }

  @override
  void initState() {
    super.initState();
    // final User user = FirebaseAuth.instance.currentUser;
    // name = user.email;
    seriesLineData = List<charts.Series<Level, int>>();
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
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     Padding(
                //       padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                //       child: CircleAvatar(
                //         radius: 40.0,
                //         backgroundColor: avatarColor,
                //         child: Text(
                //           name[0].toUpperCase(),
                //           style: TextStyle(
                //             fontSize: 40,
                //           ),
                //         ),
                //         foregroundColor: Colors.white,
                //       ),
                //     ),
                //     Padding(
                //       padding: EdgeInsets.only(top: 0, bottom: 5),
                //       child: Text(
                //         name.substring(0, name.indexOf('@')),
                //         style: TextStyle(
                //           fontWeight: FontWeight.bold,
                //           fontSize: 20,
                //           color: Theme.of(context).colorScheme.onPrimary,
                //         ),
                //       ),
                //     )
                //   ],
                // ),
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
                          // FlatButton(
                          //   onPressed: totalText,
                          //   child: Text(btnText),
                          //   height: 30.0,
                          //   color: Color(0xffEDEDED),
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(25.0),
                          //   ),
                          // ),
                          SizedBox(
                            height: 400,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                                
                              child: charts.LineChart(
                                seriesLineData,
                                defaultRenderer: new charts.LineRendererConfig(
                                  includeArea:true,
                                  stacked: false
                                ),
                                animate: true,
                                animationDuration: Duration(seconds: 2),
                                
                                behaviors: [
                                  new charts.ChartTitle('Level', 
                                  behaviorPosition: charts.BehaviorPosition.bottom,
                                  titleOutsideJustification: charts.OutsideJustification.middleDrawArea ),
                                  new charts.ChartTitle('No of questions', 
                                  behaviorPosition: charts.BehaviorPosition.start,
                                  titleOutsideJustification: charts.OutsideJustification.middleDrawArea ),
                                  
                                ],
                                
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
  // int week;
  int level;
  int levelValue;
  // Color colorval;

  Level( this.level, this.levelValue);
}
