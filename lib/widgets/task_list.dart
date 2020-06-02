import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';
import 'package:todo/widgets/task_tile.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final Function itemBuilder;

  const TaskList({Key key, this.tasks, this.itemBuilder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: itemBuilder,
      itemCount: tasks.length,
    );
  }
}
