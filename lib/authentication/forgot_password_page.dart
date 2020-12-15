import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';

import '../auth_service.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailController = TextEditingController();
  String message = "";
  bool wrongEmail = false;
  bool _emailValidate = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        return;
      },
      child: Scaffold(
        body: Center(
          child: Form(
            child: SingleChildScrollView(
              child: Container(
                // padding: new EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Reset Password",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
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
                              _emailValidate = true;
                            });
                          }
                        },
                        controller: emailController,
                        style: TextStyle(
                          color: _emailValidate
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onError,
                        ),
                        cursorColor: Theme.of(context).colorScheme.primary,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: _emailValidate
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.onError,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(40.0),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.0)),
                            borderSide: BorderSide(
                              color: _emailValidate
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.onError,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 10.0),
                          labelText: "Enter email",
                          labelStyle: TextStyle(
                            color: _emailValidate
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.onError,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: wrongEmail ? 24 : 0,
                      child: wrongEmail
                          ? Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                "Email doesnot exist",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onError,
                                ),
                              ),
                            )
                          : null,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FlatButton(
                      child: Text(
                        "Send Mail",
                        style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.primaryVariant),
                      ),
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: () async {
                        setState(() {
                          _emailValidate = (emailController.text.isEmpty ||
                                  !EmailValidator.validate(
                                      emailController.text))
                              ? false
                              : true;
                          wrongEmail = false;
                        });
                        if (_emailValidate) {
                          print(emailController.text);
                          String result =
                              await AuthService(FirebaseAuth.instance)
                                  .forgotPassword(emailController.text);

                          if (result == "Successful") {
                            setState(() {
                              message = "Email sent successfully";
                            });
                          } else {
                            setState(() {
                              wrongEmail = true;
                              _emailValidate = false;
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      message,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
