import 'package:flutter/material.dart';
import 'package:flutterfiretest/alert_dialog.dart';
import 'package:provider/provider.dart';
import 'package:flutterfiretest/auth_service.dart';

class Settings extends StatefulWidget {
  Function setIndex;
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
        backgroundColor: Theme.of(context).colorScheme.primaryVariant,
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
                              Icons.edit,
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
                              Icons.get_app,
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
                              Icons.cached,
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
                              Icons.nights_stay,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
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
      title: Text(
        'Delete Account',
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Theme.of(context).colorScheme.primaryVariant,
      content: SizedBox(
        height: 70.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextField(
              controller: passwordController,
              cursorColor: Theme.of(context).colorScheme.primary,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                ),
                hintText: "Confirm Password",
                hintStyle:
                    TextStyle(color: Theme.of(context).colorScheme.primary),
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
