import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/data/task_data.dart';
import 'package:todo/models/task.dart';
import 'package:todo/screens/login_screen.dart';
import 'package:todo/screens/registration_sreen.dart';
import 'package:todo/screens/task_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final String data = "Kelvin";
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskData>(
      create: (context) => TaskData(),
      child: MaterialApp(
        routes: {
          Registration.id: (context) => Registration(),
          Login.id: (context) => Login()
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            canvasColor: Colors.transparent, primaryColor: Colors.green),
        home: TaskScreen(),
      ),
    );
  }
}
