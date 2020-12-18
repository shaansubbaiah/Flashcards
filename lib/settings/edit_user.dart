import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../alert_dialog.dart';
import '../auth_service.dart';

class EditUser extends StatefulWidget {
  final Function setIndex;
  EditUser(this.setIndex);
  @override
  _EditUserState createState() => _EditUserState(this.setIndex);
}

class _EditUserState extends State<EditUser> {
  Function setIndex;
  _EditUserState(this.setIndex);
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  bool wrongPassword = false;
  bool _newPasswordValidate = true;
  bool _oldPasswordValidate = true;

  Future<bool> checkPassword() async {
    return await context
        .read<AuthService>()
        .checkPassword(oldPasswordController.text);
  }

  void editPassword() async {
    setState(() {
      _oldPasswordValidate = (oldPasswordController.text.isEmpty ||
              oldPasswordController.text.length < 6)
          ? false
          : true;
      _newPasswordValidate = (newPasswordController.text.isEmpty ||
              newPasswordController.text.length < 6)
          ? false
          : true;
      wrongPassword = false;
    });
    if (_newPasswordValidate && _oldPasswordValidate) {
      final action = await Dialogs.yesAbort(
          context, "Edit Password", "Are you sure?", "Edit", "No");
      if (action == DialogAction.yes) {
        if (await checkPassword()) {
          context.read<AuthService>().editPassword(newPasswordController.text);
          // Navigator.popAndPushNamed(context, "/settings");
          this.setIndex(2);
        } else {
          setState(() {
            wrongPassword = true;
            _oldPasswordValidate = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            "Edit Password",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
      body: Center(
          child: Form(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                width: 300,
                child: TextFormField(
                  onChanged: (value) {
                    if (value != "") {
                      setState(() {
                        _oldPasswordValidate = true;
                      });
                    }
                  },
                  controller: oldPasswordController,
                  obscureText: true,
                  style: TextStyle(
                    color: _oldPasswordValidate
                        ? Theme.of(context).colorScheme.primaryVariant
                        : Theme.of(context).colorScheme.onError,
                  ),
                  cursorColor: Theme.of(context).colorScheme.primaryVariant,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _oldPasswordValidate
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
                        color: _oldPasswordValidate
                            ? Theme.of(context).colorScheme.primaryVariant
                            : Theme.of(context).colorScheme.onError,
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                    labelText: "Enter old password",
                    labelStyle: TextStyle(
                      color: _oldPasswordValidate
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
                          ),
                        ),
                      )
                    : null,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: 300,
                child: TextFormField(
                  onChanged: (value) {
                    if (value != "") {
                      setState(() {
                        _newPasswordValidate = true;
                      });
                    }
                  },
                  controller: newPasswordController,
                  style: TextStyle(
                    color: _newPasswordValidate
                        ? Theme.of(context).colorScheme.primaryVariant
                        : Theme.of(context).colorScheme.onError,
                  ),
                  cursorColor: Theme.of(context).colorScheme.primaryVariant,
                  obscureText: true,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _newPasswordValidate
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
                        color: _newPasswordValidate
                            ? Theme.of(context).colorScheme.primaryVariant
                            : Theme.of(context).colorScheme.onError,
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                    labelText: "Enter password",
                    labelStyle: TextStyle(
                      color: _newPasswordValidate
                          ? Theme.of(context).colorScheme.primaryVariant
                          : Theme.of(context).colorScheme.onError,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: editPassword,
                child: Text(
                  "Edit",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primaryVariant),
                ),
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
