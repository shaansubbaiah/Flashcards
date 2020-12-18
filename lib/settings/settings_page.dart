import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutterfiretest/alert_dialog.dart';
import 'package:flutterfiretest/database.dart';
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
            "Options",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [
              Container(
                height: 55.0,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    top: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                child: ListTile(
                  leading: Icon(
                    EvaIcons.editOutline,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  title: Text(
                    "Edit Password",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
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
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                child: ListTile(
                  leading: Icon(
                    EvaIcons.refreshOutline,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  title: Text(
                    "Reset Stats",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 20,
                    ),
                  ),
                  onTap: () async {
                    final action = await Dialogs.yesAbort(
                        context, "Reset Stats", "Are you sure?", "Reset", "No");

                    if (action == DialogAction.yes) {
                      await DatabaseService()
                          .resetStats()
                          .then((value) => {print(value)})
                          .catchError((onError) => {print(onError)});
                    }
                  },
                ),
              ),
              Container(
                height: 55.0,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                child: ListTile(
                  leading: Icon(
                    EvaIcons.sunOutline,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  title: Text(
                    Provider.of<AppState>(context, listen: false).mode,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    Provider.of<AppState>(context, listen: false).changeTheme();
                    setIndex(0);
                  },
                ),
              ),
              Container(
                height: 55.0,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                child: ListTile(
                  leading: Icon(
                    EvaIcons.logOutOutline,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  title: Text(
                    "Logout",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 20,
                    ),
                  ),
                  onTap: () async {
                    final action = await Dialogs.yesAbort(
                        context, "Logout", "Are you sure?", "Logout", "No");

                    if (action == DialogAction.yes) {
                      context.read<AuthService>().signOut();
                    }
                  },
                ),
              ),
              Container(
                height: 55.0,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                child: ListTile(
                  leading: Icon(
                    EvaIcons.personDeleteOutline,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  title: Text(
                    "Delete Account",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return DeleteAlert();
                      },
                    );
                  },
                ),
              ),
            ],
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
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
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
                      ? Theme.of(context).colorScheme.primaryVariant
                      : Theme.of(context).colorScheme.onError,
                ),
                cursorColor: Theme.of(context).colorScheme.primaryVariant,
                obscureText: true,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _passwordValidate
                          ? Theme.of(context).colorScheme.primaryVariant
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
                          ? Theme.of(context).colorScheme.primaryVariant
                          : Theme.of(context).colorScheme.onError,
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                  labelText: "Confirm password",
                  labelStyle: TextStyle(
                    color: _passwordValidate
                        ? Theme.of(context).colorScheme.primaryVariant
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
                            fontSize: 12),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
      actions: [
        FlatButton.icon(
          icon: Icon(
            EvaIcons.closeOutline,
            color: Color(0xff950F0F),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            passwordController.text = "";
            wrongPassword = false;
          },
          label: Text(
            "Cancel",
            style: TextStyle(
              color: Color(0xff950F0F),
            ),
          ),
          height: 30.0,
          color: Color(0xffEDA9A9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        FlatButton.icon(
          icon: Icon(
            EvaIcons.checkmarkOutline,
            color: Color(0xff08913F),
          ),
          onPressed: () {
            deleteAccount();
          },
          label: Text(
            "Confirm",
            style: TextStyle(
              color: Color(0xff08913F),
            ),
          ),
          height: 30.0,
          color: Color(0xffA9EDC4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ],
    );
  }
}
