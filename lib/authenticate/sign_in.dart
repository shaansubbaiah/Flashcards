import 'package:flashcard/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  final Function toggle;
  SignIn({this.toggle});

  final _auth = AuthService();
  final password = TextEditingController();
  final email = TextEditingController();
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
                      controller: email,
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
                      controller: password,
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
                        dynamic result =
                            await _auth.signIn(email.text, password.text);
                        print(result);
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
