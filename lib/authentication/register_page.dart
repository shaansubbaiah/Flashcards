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

  bool wrongEmail = false;
  bool _emailValidate = true;
  bool _passwordValidate = true;

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
                                "Email already exists",
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.0)),
                            borderSide: BorderSide(
                              color: _passwordValidate
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.onError,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 10.0),
                          labelText: "Enter password",
                          labelStyle: TextStyle(
                            color: _passwordValidate
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.onError,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
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
                        setState(() {
                          _emailValidate = (emailController.text.isEmpty ||
                                  !EmailValidator.validate(
                                      emailController.text))
                              ? false
                              : true;
                          _passwordValidate =
                              (passwordController.text.isEmpty ||
                                      passwordController.text.length < 6)
                                  ? false
                                  : true;
                          wrongEmail = false;
                        });
                        if (_emailValidate && _passwordValidate) {
                          String result =
                              await context.read<AuthService>().signUp(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  );
                          if (result == "email exists") {
                            setState(() {
                              wrongEmail = true;
                              _emailValidate = false;
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
