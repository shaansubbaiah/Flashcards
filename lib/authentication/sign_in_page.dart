import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth_service.dart';
import 'package:email_validator/email_validator.dart';

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

  // final Function toggle;
  // _SignInPageState({this.toggle});

  final form = GlobalKey<FormState>();

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
                    "Signin",
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
                      obscureText: true,
                      cursorColor: Theme.of(context).colorScheme.primary,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      decoration: InputDecoration(
                        // icon: Icon(Icons.lock),
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
                        labelText: "Password",
                        labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                        errorText: wrongPassword ? "Wrong Password" : null,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 10.0),
                        // fillColor: Colors.grey[300],
                      ),
                    ),
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
                  FlatButton(
                    child: Text(
                      "Signin",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primaryVariant),
                    ),
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () async {
                      setState(() {
                        wrongEmail = wrongPassword = false;
                      });
                      if (form.currentState.validate()) {
                        String result =
                            await context.read<AuthService>().signIn(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                );

                        if (result == "user-not-found") {
                          setState(() {
                            wrongEmail = true;
                          });
                        } else if (result == "wrong-password") {
                          setState(() {
                            wrongPassword = true;
                          });
                        }
                      }
                    },
                  ),
                  Container(
                    padding: EdgeInsets.all(30.0),
                    child: FlatButton(
                        textColor: Theme.of(context).colorScheme.onPrimary,
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
