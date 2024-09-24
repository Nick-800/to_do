import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/models/task_model.dart';

class TasksProvider with ChangeNotifier {
  List<TaskModel> tasks = [];

  addTask(TaskModel tm) {
    tasks.add(tm);
    storeTasks();
    notifyListeners();
  }

  delete(TaskModel tm) {
    tasks.remove(tm);
    storeTasks();
    notifyListeners();
  }

  edit(TaskModel tm, TaskModel oldTm) {
    tasks.remove(oldTm);
    tasks.add(tm);
    storeTasks();

    notifyListeners();
  }

  switchValue(TaskModel tm) {
    tm.isCompleted = !tm.isCompleted;
    storeTasks();

    notifyListeners();
  }

  storeTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var json =
        jsonEncode(tasks.map((taskModel) => taskModel.toJson()).toList());

    if (kDebugMode) {
      print("JSON FROM STORE $json");
    }
    prefs.setString("tasks", json);
    getTasks();
  }

  getTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var data = prefs.getString("tasks");
    if (kDebugMode) {
      print("JSON FROM GET $data");
    }
    if (data != null) {
      tasks = List<TaskModel>.from(
          jsonDecode(data).map((x) => TaskModel.fromJson(x)));
      notifyListeners();
    }
  }
}
