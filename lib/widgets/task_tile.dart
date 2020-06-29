import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/data/task_data.dart';
import 'package:todo/main.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String title;
  final Function checkBoxToggle;

  const TaskTile({Key key, this.isChecked, this.title, this.checkBoxToggle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TaskData>(context);
    return ListTile(
        title: Text(
          title,
          style: TextStyle(
              color: Colors.lightBlue,
              decoration: isChecked ? TextDecoration.lineThrough : null),
        ),
        trailing: Checkbox(
          value: isChecked,
          activeColor: Colors.lightBlueAccent,
          onChanged: checkBoxToggle,
        ));
  }
}
