import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/constants.dart';
import 'package:todo/screens/task_screen.dart';

class Login extends StatefulWidget {
  static const String id = "login";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: Image.network(
                  "https://moringaschool.com/static/img/logo.png"),
            ),
            TextField(
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              decoration: kDarkInputDecoration,
              onChanged: (value) {
                email = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
              decoration: kDarkInputDecoration,
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              color: Color(0xFF404d1c),
              disabledColor: Color(0xFF404d1c),
              padding: EdgeInsets.all(10),
              onPressed: () async {
                try {
                  final newUser = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  if (newUser != null) {
                    Navigator.pushNamed(context, TaskScreen.id);
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white, fontSize: 19),
              ),
            )
          ],
        ),
      ),
    );
  }
}
