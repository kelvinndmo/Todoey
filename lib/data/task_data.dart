import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo/models/task.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class TaskData extends ChangeNotifier {
  List<Task> tasks = [
    Task(title: "work on today"),
    Task(title: "kelvin"),
    Task(title: 'walk to school')
  ];

  addTask(Task task) {
    tasks.add(task);
    notifyListeners();
  }

  toggleTask(int index) {
    tasks[index].isCompleted = !tasks[index].isCompleted;
    notifyListeners();
  }
}
