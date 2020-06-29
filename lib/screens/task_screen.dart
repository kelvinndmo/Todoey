import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/constants.dart';
import 'package:todo/data/task_data.dart';
import 'package:todo/main.dart';
import 'package:todo/models/task.dart';
import 'package:todo/screens/add_task_screen.dart';
import 'package:todo/widgets/task_list.dart';
import 'package:todo/widgets/task_tile.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInuser;

class TaskScreen extends StatefulWidget {
  static const String id = "tasks";
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInuser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.height;
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
        backgroundColor: Colors.lightBlue,
        child: Icon(Icons.add),
      ),
      backgroundColor: kPrimaryColor,
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: size * .40,
          padding: EdgeInsets.only(top: 40, left: 5, right: 5, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: TypewriterAnimatedTextKit(
                  speed: Duration(seconds: 1),
                  text: ["Hello,Novak"],
                  totalRepeatCount: 1,
                  textStyle: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                  textAlign: TextAlign.start,
                  alignment: AlignmentDirectional.topStart,
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: kDarkBoxShadow,
                      borderRadius: BorderRadius.circular(10),
                      color: kPrimaryColor),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: (Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TopCardItem(
                            color: Colors.green,
                            icon: Icons.check,
                            total: 12,
                            title: 'Completed'),
                        TopCardItem(
                          color: Colors.yellow,
                          icon: Icons.warning,
                          total: 12,
                          title: "Pending",
                        ),
                      ],
                    )),
                  ),
                ),
              )
              // CircleAvatar(
              //     radius: 30,
              //     backgroundColor: Colors.white,
              //     child: Icon(
              //       Icons.list,
              //       color: Color(0xFF404d1c),
              //       size: 30,
              //     )),
              // SizedBox(
              //   height: 10,
              // ),
              // Text("Todo",
              //     style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 50.0,
              //         fontWeight: FontWeight.w700)),
              // Text(
              //   '$tasksNumber tasks',
              //   style: TextStyle(color: Colors.white, fontSize: 18),
              // ),
            ],
          ),
        ),
        Expanded(
          child: Container(
              decoration: BoxDecoration(
                  boxShadow: kDarkBoxShadow,
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: TaskStream()),
        )
      ]),
    );
  }
}

class TopCardItem extends StatelessWidget {
  final Color color;
  final String title;
  final int total;
  final IconData icon;

  const TopCardItem({
    Key key,
    this.color,
    this.title,
    this.total,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // padding: EdgeInsets.all(7),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: color.withOpacity(.25)),
          child: Icon(
            icon,
            color: color,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "$total",
          style: TextStyle(fontSize: 30, color: color),
        ),
        Text(
          "$title",
          style: TextStyle(fontSize: 16, color: Colors.white),
        )
      ],
    );
  }
}

int tasksNumber = 0;

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
          final currentUser = loggedInuser.email;
          print(currentUser);
          if (taskDoc.data['creator'] == currentUser) {
            final titleText = taskDoc.data["title"];
            final creator = taskDoc.data["creator"];
            final isChecked = taskDoc.data["is_completed"];

            final taskTile = TaskTile(
              isChecked: isChecked,
              title: titleText,
              checkBoxToggle: (value) {
                _firestore
                    .collection("todos")
                    .document(taskDoc.documentID)
                    .updateData({"is_completed": !taskDoc["is_completed"]});
              },
            );

            taskTiles.add(taskTile);
            tasksNumber = taskTiles.length;
          }
        }

        return ListView(
          children: taskTiles,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        );
      },
    );
  }
}
