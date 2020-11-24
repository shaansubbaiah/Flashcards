import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../alert_dialog.dart';
import '../auth_service.dart';

class EditUser extends StatefulWidget {
  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
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
          Navigator.popAndPushNamed(context, "/settings");
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
      body: Container(
          padding: EdgeInsets.only(top: 50.0, right: 20.0, left: 20.0),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40.0,
                    child: Text(
                      "Edit Password",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Center(
                    child: Form(
                      key: form,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 40, top: 2.5, right: 40, bottom: 2.5),
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
                              decoration: InputDecoration(
                                // icon: Icon(Icons.lock),
                                labelText: "Old Password",
                                errorText:
                                    wrongPassword ? "Wrong Password" : null,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40.0)),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 10.0),
                                // fillColor: Colors.grey[300],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 40, top: 2.5, right: 40, bottom: 5),
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
                              obscureText: true,
                              decoration: InputDecoration(
                                // icon: Icon(Icons.lock),
                                labelText: "New Password",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40.0)),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 10.0),
                                // fillColor: Colors.grey[300],
                              ),
                            ),
                          ),
                          RaisedButton(
                            onPressed: editPassword,
                            child: Text(
                              "Edit",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.teal,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
