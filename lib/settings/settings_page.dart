import 'package:flutter/material.dart';
import 'package:flutterfiretest/alert_dialog.dart';
import 'package:provider/provider.dart';
import 'package:flutterfiretest/auth_service.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(top: 50.0, right: 20.0, left: 20.0),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40.0,
                      child: Text(
                        "Settings",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    ListView(
                      shrinkWrap: true,
                      children: [
                        Container(
                          height: 55.0,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xff9E9D9D),
                              ),
                              top: BorderSide(
                                color: Color(0xff9E9D9D),
                              ),
                            ),
                          ),
                          child: ListTile(
                            leading: Icon(Icons.edit),
                            title: Text(
                              "Edit Password",
                              style: TextStyle(
                                color: Color(0xff9E9D9D),
                                fontSize: 20,
                              ),
                            ),
                            onTap: () {
                              Navigator.popAndPushNamed(
                                  context, "/settings/editUser");
                            },
                          ),
                        ),
                        Container(
                          height: 55.0,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xff9E9D9D),
                              ),
                            ),
                          ),
                          child: ListTile(
                            leading: Icon(Icons.get_app),
                            title: Text(
                              "Restore Backup",
                              style: TextStyle(
                                color: Color(0xff9E9D9D),
                                fontSize: 20,
                              ),
                            ),
                            onTap: () {
                              print("edit");
                            },
                          ),
                        ),
                        Container(
                          height: 55.0,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xff9E9D9D),
                              ),
                            ),
                          ),
                          child: ListTile(
                            leading: Icon(Icons.cached),
                            title: Text(
                              "Reset Stats",
                              style: TextStyle(
                                color: Color(0xff9E9D9D),
                                fontSize: 20,
                              ),
                            ),
                            onTap: () {
                              print("edit");
                            },
                          ),
                        ),
                        Container(
                          height: 55.0,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xff9E9D9D),
                              ),
                            ),
                          ),
                          child: ListTile(
                            leading: Icon(Icons.nights_stay),
                            title: Text(
                              "Night Mode",
                              style: TextStyle(
                                color: Color(0xff9E9D9D),
                                fontSize: 20,
                              ),
                            ),
                            onTap: () {
                              print("edit");
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 200.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FlatButton(
                          onPressed: () async {
                            final action = await Dialogs.yesAbort(context,
                                "Logout", "Are you sure?", "Logout", "No");

                            if (action == DialogAction.yes) {
                              context.read<AuthService>().signOut();
                            }
                          },
                          child: Text(
                            "Logout",
                            style: TextStyle(
                              color: Color(0xff08913F),
                              fontSize: 30,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          height: 50.0,
                          color: Color(0xffA9EDC4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return DeleteAlert();
                              },
                            );
                          },
                          child: Text(
                            "Delete",
                            style: TextStyle(
                              color: Color(0xff950F0F),
                              fontSize: 30,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          height: 50.0,
                          color: Color(0xffEDA9A9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DeleteAlert extends StatefulWidget {
  @override
  _DeleteAlertState createState() => _DeleteAlertState();
}

class _DeleteAlertState extends State<DeleteAlert> {
  bool wrongPassword = false;

  final TextEditingController passwordController = TextEditingController();

  Future<bool> checkPassword() async {
    return await context
        .read<AuthService>()
        .checkPassword(passwordController.text);
  }

  void deleteAccount() async {
    if (await checkPassword()) {
      context.read<AuthService>().deleteUser(passwordController.text);
      Navigator.of(context).pop();
    } else {
      setState(() {
        wrongPassword = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete Account'),
      content: SizedBox(
        height: 70.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: "Confirm Password",
                errorText: wrongPassword ? "Wrong Password" : null,
              ),
            ),
          ],
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
            passwordController.text = "";
            wrongPassword = false;
          },
          child: Text("Cancel"),
        ),
        RaisedButton(
          onPressed: () {
            deleteAccount();
          },
          child: Text("Delete"),
        ),
      ],
    );
  }
}
