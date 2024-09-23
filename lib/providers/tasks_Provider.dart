import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:to_do/models/task_models.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TasksProvider  with ChangeNotifier {

  List<TaskModel>  tasks =[];

  addTask(TaskModel tm){
    tasks.add(tm);
    storeTasks();
    notifyListeners();
  }

  deleteTask(TaskModel tm){
    tasks.remove(tm);
    storeTasks();
    notifyListeners();
  }

  editTask(TaskModel tm  , TaskModel oldTm){
    tasks [tasks.indexOf(oldTm)]=tm;
    storeTasks();
    notifyListeners();
  }
  switchState(TaskModel tm){
    tm.status=!tm.status;
    storeTasks();
    notifyListeners();
  }

  storeTasks() async {
    try {
      print("555555555555555555555555555555555");
      SharedPreferences pref = await SharedPreferences.getInstance();
      var json = jsonEncode(tasks.map((task) => task.toJson()).toList());
      print("Storing tasks: $json"); // Debug line
      await pref.setString("tasks", json);
      print("Tasks stored successfully.");
    } catch (e) {
      print("Error storing tasks: $e");
    }
  }
  getTasks() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var data = pref.getString("tasks");
      print("Retrieved tasks data: $data"); // Debug line
      if (data != null) {
        List<TaskModel> loadedTasks = List<TaskModel>.from(
            jsonDecode(data).map((task) => TaskModel.fromJson(task)));
        print("Loaded tasks: $loadedTasks"); // Debug line
        if (loadedTasks != tasks) {
          tasks = loadedTasks;
          notifyListeners();
        }
      }
    } catch (e) {
      print("Error retrieving tasks: $e");
    }
  }



}