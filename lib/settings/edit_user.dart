import 'package:carousel_slider/carousel_options.dart';
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
  final form = GlobalKey<FormState>();
  bool wrongPassword = false;

  Future<bool> checkPassword() async {
    return await context
        .read<AuthService>()
        .checkPassword(oldPasswordController.text);
  }

  void editPassword() async {
    if (form.currentState.validate()) {
      final action = await Dialogs.yesAbort(
          context, "Edit Password", "Are you sure?", "Edit", "No");
      if (action == DialogAction.yes) {
        if (await checkPassword()) {
          context.read<AuthService>().editPassword(oldPasswordController.text);
          // Navigator.popAndPushNamed(context, "/settings");
          this.setIndex(2);
        } else {
          setState(() {
            wrongPassword = true;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryVariant,
        title: Center(
          child: Text(
            "Edit Password",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ),
      body: Center(
          child: Form(
        key: form,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:
                  EdgeInsets.only(left: 40, top: 2.5, right: 40, bottom: 2.5),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter password';
                  } else if (value.length < 6) {
                    return 'Min length is 6';
                  }
                  return null;
                },
                controller: oldPasswordController,
                obscureText: true,
                cursorColor: Theme.of(context).colorScheme.primary,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
                decoration: InputDecoration(
                  // icon: Icon(Icons.lock),
                  labelText: "Old Password",
                  labelStyle:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                    borderRadius: BorderRadius.all(
                      Radius.circular(40.0),
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onError),
                    borderRadius: BorderRadius.all(
                      Radius.circular(40.0),
                    ),
                  ),
                  errorText: wrongPassword ? "Wrong Password" : null,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                  // fillColor: Colors.grey[300],
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 40, top: 2.5, right: 40, bottom: 5),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter password';
                  } else if (value.length < 6) {
                    return 'Min length is 6';
                  }
                  return null;
                },
                controller: newPasswordController,
                cursorColor: Theme.of(context).colorScheme.primary,
                obscureText: true,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
                decoration: InputDecoration(
                  // icon: Icon(Icons.lock),
                  labelText: "New Password",
                  labelStyle:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                    borderRadius: BorderRadius.all(
                      Radius.circular(40.0),
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onError),
                    borderRadius: BorderRadius.all(
                      Radius.circular(40.0),
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                  // fillColor: Colors.grey[300],
                ),
              ),
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
      )),
    );
  }
}
