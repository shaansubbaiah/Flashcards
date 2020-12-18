import 'package:flutter/material.dart';
import 'package:flutterfiretest/database.dart';
import 'package:flutterfiretest/stats/line_chart.dart';
import 'package:flutterfiretest/stats/pie_chart.dart';

class StatsPage extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  LineChart _lineChart;
  PieChart _pieChart;

  List count;
  String btnDeckText = "Total Decks";
  String btnCardText = "Total Cards";
  void getTotal() async {
    count = await DatabaseService().getTotalCount();
  }

  void totalDeck() {
    if (!mounted) return;
    setState(() {
      btnDeckText =
          (btnDeckText == "Total Decks") ? count[0].toString() : "Total Decks";
    });
  }

  void totalCard() {
    if (!mounted) return;
    setState(() {
      btnCardText =
          (btnCardText == "Total Cards") ? count[1].toString() : "Total Cards";
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pieChart = new PieChart();
    _lineChart = new LineChart();
    getTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            "Statistics",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Theme.of(context).colorScheme.primary,
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
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Theme.of(context).colorScheme.surface,
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FlatButton(
                          color: Colors.orange.withOpacity(0.2),
                          textColor: Colors.orange,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                          ),
                          child: Text(btnDeckText),
                          onPressed: totalDeck,
                        ),
                        FlatButton(
                          color: Colors.green.withOpacity(0.2),
                          textColor: Colors.green,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                          ),
                          child: Text(btnCardText),
                          onPressed: totalCard,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Theme.of(context).colorScheme.surface,
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _lineChart,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Theme.of(context).colorScheme.surface,
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _pieChart,
                  ),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
