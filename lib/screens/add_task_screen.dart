import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/data/task_data.dart';
import 'package:todo/main.dart';
import 'package:todo/models/task.dart';

class AddTask extends StatefulWidget {
  final Function onPressAdd;

  const AddTask({Key key, this.onPressAdd}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String title;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TaskData>(context);
    var size = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Add Task",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xFF404d1c),
                    fontSize: 30,
                    fontWeight: FontWeight.w400),
              ),
              TextField(
                autofocus: true,
                textAlign: TextAlign.center,
                cursorColor: Color(0xFF404d1c),
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
                },
                decoration: InputDecoration(
                    focusColor: Color(0xFF404d1c),
                    fillColor: Colors.lightBlueAccent,
                    contentPadding: EdgeInsets.symmetric(horizontal: 30)),
              ),
              SizedBox(
                height: 30,
              ),
              FlatButton(
                  color: Color(0xFF404d1c),
                  textColor: Colors.white,
                  onPressed: () {
                    if (title != null) {}
                    provider.addTask(Task(title: title));
                    Navigator.pop(context);
                  },
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Text('Add Task', style: TextStyle(fontSize: 20)))),
            ],
          ),
        ),
      ),
    );
  }
}
