import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/screens/login_screen.dart';

class Registration extends StatefulWidget {
  static const String id = "registration";
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                color: Color(0xFF404d1c),
              ),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                email = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              style: TextStyle(color: Color(0xFF404d1c)),
              textAlign: TextAlign.center,
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
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);
                  if (newUser != null) {
                    print(newUser);
                    Navigator.pushNamed(context, Login.id);
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: Text(
                "Register",
                style: TextStyle(color: Colors.white, fontSize: 19),
              ),
            )
          ],
        ),
      ),
    );
  }
}
