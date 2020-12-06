import 'dart:math';

import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String btn1Text = "Total Cards";
  String btn2Text = "Correct Cards";
  String btn3Text = "Wrong Cards";

  void btn1() {
    setState(() {
      btn1Text = "10";
    });
  }

  void btn2() {
    setState(() {
      btn2Text = "7";
    });
  }

  void btn3() {
    setState(() {
      btn3Text = "3";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            "Profile",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black,
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
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: CircleAvatar(
                        radius: 40.0,
                        backgroundColor: Colors.primaries[
                            Random().nextInt(Colors.primaries.length)],
                        child: Text(
                          "A",
                          style: TextStyle(
                            fontSize: 40,
                          ),
                        ),
                        foregroundColor: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Text(
                        "name",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FlatButton(
                          onPressed: btn1,
                          child: Text(btn1Text),
                          height: 30.0,
                          color: Color(0xffEDEDED),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        FlatButton(
                          onPressed: btn2,
                          child: Text(btn2Text),
                          height: 30.0,
                          color: Color(0xffEDEDED),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        FlatButton(
                          onPressed: btn3,
                          child: Text(btn3Text),
                          height: 30.0,
                          color: Color(0xffEDEDED),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
