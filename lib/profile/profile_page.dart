import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String btn1Text = "Total Cards";
  String btn2Text = "Correct Cards";
  String btn3Text = "Wrong Cards";
  String name;

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
  void initState() {
    // TODO: implement initState
    super.initState();
    final User user = FirebaseAuth.instance.currentUser;
    name = user.email;
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
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: CircleAvatar(
                        radius: 40.0,
                        backgroundColor: Colors.primaries[
                            Random().nextInt(Colors.primaries.length)],
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
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Text(
                        name.substring(0, name.indexOf('@')),
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
