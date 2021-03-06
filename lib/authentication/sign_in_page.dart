import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutterfiretest/auth_service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class SignInPage extends StatefulWidget {
  final Function toggle;
  SignInPage(this.toggle);

  @override
  _SignInPageState createState() => _SignInPageState(this.toggle);
}

class _SignInPageState extends State<SignInPage> {
  Function toggle;
  _SignInPageState(this.toggle);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool wrongEmail = false;
  bool wrongPassword = false;
  bool _emailValidate = true;
  bool _passwordValidate = true;

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sign In",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Theme.of(context).colorScheme.primary,
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
                            wrongPassword = false;
                            wrongEmail = false;
                          });
                        }
                      },
                      controller: emailController,
                      style: TextStyle(
                        color: _emailValidate
                            ? Theme.of(context).colorScheme.primaryVariant
                            : Theme.of(context).colorScheme.onError,
                      ),
                      cursorColor: Theme.of(context).colorScheme.primaryVariant,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: _emailValidate
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
                            color: _emailValidate
                                ? Theme.of(context).colorScheme.primaryVariant
                                : Theme.of(context).colorScheme.onError,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 10.0),
                        labelText: "Enter email",
                        labelStyle: TextStyle(
                          color: _emailValidate
                              ? Theme.of(context).colorScheme.primaryVariant
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
                            wrongPassword = false;
                            wrongEmail = false;
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
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 10.0),
                        labelText: "Enter Password",
                        labelStyle: TextStyle(
                          color: _passwordValidate
                              ? Theme.of(context).colorScheme.primaryVariant
                              : Theme.of(context).colorScheme.onError,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: wrongPassword ? 30 : 0,
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
                  FlatButton(
                    textColor: Theme.of(context).colorScheme.secondary,
                    onPressed: () {
                      Navigator.popAndPushNamed(context, "/forgotPassword");
                    },
                    child: Text(
                      "Forgot Password?",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  FlatButton.icon(
                    icon: Icon(
                      EvaIcons.checkmarkOutline,
                      color: Theme.of(context).colorScheme.primaryVariant,
                    ),
                    label: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryVariant,
                      ),
                    ),
                    height: 30.0,
                    color: Theme.of(context)
                        .colorScheme
                        .primaryVariant
                        .withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    onPressed: () async {
                      setState(() {
                        _emailValidate = (emailController.text.isEmpty ||
                                !EmailValidator.validate(emailController.text))
                            ? false
                            : true;
                        _passwordValidate = (passwordController.text.isEmpty ||
                                passwordController.text.length < 6)
                            ? false
                            : true;
                        wrongEmail = wrongPassword = false;
                      });
                      if (_emailValidate && _passwordValidate) {
                        String result =
                            await context.read<AuthService>().signIn(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                );

                        if (result == "user-not-found") {
                          setState(() {
                            wrongEmail = true;
                            _emailValidate = false;
                          });
                        } else if (result == "wrong-password") {
                          setState(() {
                            wrongPassword = true;
                            _passwordValidate = false;
                          });
                        }
                      }
                    },
                  ),
                  Container(
                    padding: EdgeInsets.all(30.0),
                    child: FlatButton(
                        textColor: Theme.of(context).colorScheme.primary,
                        child: Text("Create an account"),
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
    );
  }
}
