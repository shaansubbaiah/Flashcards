import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterfiretest/auth_service.dart';
import 'package:email_validator/email_validator.dart';

class RegisterPage extends StatefulWidget {
  final Function toggle;
  RegisterPage(this.toggle);
  @override
  _RegisterPageState createState() => _RegisterPageState(this.toggle);
}

class _RegisterPageState extends State<RegisterPage> {
  Function toggle;
  _RegisterPageState(this.toggle);
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final form = GlobalKey<FormState>();

  bool wrongEmail = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        toggle();
        return;
      },
      child: Scaffold(
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
                      "Register",
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
                          errorText: wrongEmail ? "Email already exists" : null,
                          labelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.0)),
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
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 10.0),
                          // fillColor: Colors.grey[300],
                        ),
                      ),
                    ),
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
                        controller: passwordController,
                        cursorColor: Theme.of(context).colorScheme.primary,
                        obscureText: true,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        decoration: InputDecoration(
                          // icon: Icon(Icons.lock),
                          labelText: "Password",
                          labelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.0)),
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
                        "Register",
                        style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.primaryVariant),
                      ),
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: () async {
                        if (form.currentState.validate()) {
                          String result =
                              await context.read<AuthService>().signUp(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  );
                          if (result == "email exists") {
                            setState(() {
                              wrongEmail = true;
                            });
                          }
                        }
                      },
                    ),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: FlatButton(
                          textColor: Theme.of(context).colorScheme.onPrimary,
                          child: Text("Already have an Account?"),
                          onPressed: () {
                            toggle();
                          }),
                    )
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
