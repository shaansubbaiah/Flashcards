import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_service.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final Function toggle;
  SignInPage({this.toggle});

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
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 40, top: 10, right: 40, bottom: 2.5),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter email';
                        }
                        return null;
                      },
                      controller: emailController,
                      decoration: InputDecoration(
                        // icon: Icon(Icons.email),
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
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
                      decoration: InputDecoration(
                        // icon: Icon(Icons.lock),
                        labelText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 10.0),
                        // fillColor: Colors.grey[300],
                      ),
                    ),
                  ),
                  FlatButton(
                    textColor: Colors.grey[275],
                    onPressed: null,
                    child: Text("Forgot Password?"),
                  ),
                  FlatButton(
                    child: Text(
                      "Signin",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue[400],
                    onPressed: () async {
                      if (form.currentState.validate()) {
                        context.read<AuthService>().signIn(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );
                      }
                    },
                  ),
                  Container(
                    padding: EdgeInsets.all(30.0),
                    child: FlatButton(
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