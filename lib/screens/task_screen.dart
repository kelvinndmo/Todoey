import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/data/task_data.dart';
import 'package:todo/main.dart';
import 'package:todo/models/task.dart';
import 'package:todo/screens/add_task_screen.dart';
import 'package:todo/widgets/task_list.dart';
import 'package:todo/widgets/task_tile.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInuser;

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final _auth = FirebaseAuth.instance;
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInuser = user;
      }
    } catch (e) {}
  }

  @override
  void initState() {
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TaskData>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) => AddTask(
                    onPressAdd: (value) {
                      provider.addTask(Task(title: value));

                      Navigator.pop(context);
                    },
                  ));
        },
        backgroundColor: Color(0xFF404d1c),
        child: Icon(Icons.add),
      ),
      backgroundColor: Color(0xFF404d1c),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.list,
                    color: Color(0xFF404d1c),
                    size: 30,
                  )),
              SizedBox(
                height: 10,
              ),
              Text("Todo",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50.0,
                      fontWeight: FontWeight.w700)),
              Text(
                '${provider.tasks.length.toString()} tasks',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.red,
          child: TaskStream(),
        )
      ]),
    );
  }
}

class TaskStream extends StatelessWidget {
  final _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('todos').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.green,
            ),
          );
        }

        final tasks = snapshot.data.documents.reversed;
        List<TaskTile> taskTiles = [];
        for (var taskDoc in tasks) {
          final titleText = taskDoc.data["title"];
          final creator = taskDoc.data["creator"];
          final isChecked = taskDoc.data["isCompleted"];

          final currentUser = loggedInuser.email;

          final taskTile = TaskTile(
            isChecked: false,
            title: titleText,
            checkBoxToggle: (value) {
              _firestore
                  .collection("todos")
                  .document(taskDoc.documentID)
                  .updateData({"is_completed": !taskDoc["is_completed"]});
            },
          );

          taskTiles.add(taskTile);
        }

        return Expanded(
          child: ListView(
            reverse: true,
            children: taskTiles,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
        );
      },
    );
  }
}
