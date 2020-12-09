import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import '../auth_service.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailController = TextEditingController();
  final form = GlobalKey<FormState>();
  String message = "";
  bool wrongEmail = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: form,
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
                  Padding(
                    padding: EdgeInsets.only(
                        left: 40, top: 10, right: 40, bottom: 2.5),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter email';
                        } else if (!EmailValidator.validate(value)) {
                          return 'Please enter valid email';
                        }
                        return null;
                      },
                      controller: emailController,
                      cursorColor: Theme.of(context).colorScheme.primary,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      decoration: InputDecoration(
                        // icon: Icon(Icons.email),
                        labelText: "Email",
                        labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                        errorText: wrongEmail ? "Email doesn't exist" : null,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.onError),
                          borderRadius: BorderRadius.all(
                            Radius.circular(40.0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary),
                          borderRadius: BorderRadius.all(
                            Radius.circular(40.0),
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 10.0),
                        // fillColor: Colors.grey[300],
                      ),
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      "Send Mail",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primaryVariant),
                    ),
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () async {
                      if (form.currentState.validate()) {
                        wrongEmail = false;
                        print(emailController.text);
                        String result = await AuthService(FirebaseAuth.instance)
                            .forgotPassword(emailController.text);

                        if (result == "Successful") {
                          setState(() {
                            message = "Email sent successfully";
                          });
                        } else {
                          setState(() {
                            wrongEmail = true;
                          });
                        }
                      }
                    },
                  ),
                  Text(message),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
