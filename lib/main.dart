import 'package:flutter/material.dart';
import 'package:to_do/providers/tasks_Provider.dart';
import 'package:to_do/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<TasksProvider>(create: (_) => TasksProvider())
    ],
    child: MaterialApp(theme: ThemeData.fallback(), home: HomeScreen()),
  ));
}
