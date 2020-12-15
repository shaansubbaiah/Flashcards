import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutterfiretest/alert_dialog.dart';
import 'package:provider/provider.dart';
import 'package:flutterfiretest/auth_service.dart';

import '../app_state.dart';

class Settings extends StatefulWidget {
  final Function setIndex;
  Settings(this.setIndex);
  @override
  _SettingsState createState() => _SettingsState(this.setIndex);
}

class _SettingsState extends State<Settings> {
  Function setIndex;
  _SettingsState(this.setIndex);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            "Settings",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(top: 50.0, right: 20.0, left: 20.0),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListView(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      children: [
                        Container(
                          height: 55.0,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                              top: BorderSide(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                            ),
                          ),
                          child: ListTile(
                            leading: Icon(
                              EvaIcons.editOutline,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                            title: Text(
                              "Edit Password",
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                fontSize: 20,
                              ),
                            ),
                            onTap: () {
                              this.setIndex(5);
                            },
                          ),
                        ),
                        Container(
                          height: 55.0,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                            ),
                          ),
                          child: ListTile(
                            leading: Icon(
                              EvaIcons.downloadOutline,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                            title: Text(
                              "Restore Backup",
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
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
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                            ),
                          ),
                          child: ListTile(
                            leading: Icon(
                              EvaIcons.refreshOutline,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                            title: Text(
                              "Reset Stats",
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
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
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                            ),
                          ),
                          child: ListTile(
                            leading: Icon(
                              EvaIcons.sunOutline,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                            title: Text(
                              Provider.of<AppState>(context, listen: false)
                                  .mode,
                              style: TextStyle(
                                color: Color(0xff9E9D9D),
                                fontSize: 20,
                              ),
                            ),
                            onTap: () {
                              Provider.of<AppState>(context, listen: false)
                                  .changeTheme();
                              setIndex(0);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 190.0,
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
  bool _passwordValidate = true;

  final TextEditingController passwordController = TextEditingController();

  Future<bool> checkPassword() async {
    return await context
        .read<AuthService>()
        .checkPassword(passwordController.text);
  }

  void deleteAccount() async {
    setState(() {
      _passwordValidate = (passwordController.text.isEmpty ||
              passwordController.text.length < 6)
          ? false
          : true;
      wrongPassword = false;
    });
    if (_passwordValidate) {
      if (await checkPassword()) {
        await context.read<AuthService>().deleteUser(passwordController.text);
        Navigator.of(context).pop();
      } else {
        setState(() {
          wrongPassword = true;
          _passwordValidate = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Delete Account',
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Theme.of(context).colorScheme.primaryVariant,
      content: SizedBox(
        height: 75.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 50,
              // width: 0,
              child: TextFormField(
                onChanged: (value) {
                  if (value != "") {
                    setState(() {
                      _passwordValidate = true;
                    });
                  }
                },
                controller: passwordController,
                style: TextStyle(
                  color: _passwordValidate
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onError,
                ),
                cursorColor: Theme.of(context).colorScheme.primary,
                obscureText: true,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _passwordValidate
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onError,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(40.0),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    borderSide: BorderSide(
                      color: _passwordValidate
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onError,
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                  labelText: "Confirm password",
                  labelStyle: TextStyle(
                    color: _passwordValidate
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onError,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: wrongPassword ? 24 : 0,
              child: wrongPassword
                  ? Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "Wrong Password",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onError,
                            fontSize: 14),
                      ),
                    )
                  : null,
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
