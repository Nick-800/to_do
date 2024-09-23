import 'package:flutter/material.dart';
import 'package:to_do/models/task_models.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({super.key, required this.taskModel});

  final TaskModel taskModel;

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.taskModel.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Title:  ${widget.taskModel.title}",
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.taskModel.subTitle ?? "",
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.normal),
            ),
            Icon(widget.taskModel.status ? Icons.check : Icons.cancel_outlined,
                size: 200,
                color: widget.taskModel.status ? Colors.green : Colors.red),
            Text(
                "Created At : ${widget.taskModel.createdAt.toString().substring(0, 10).replaceAll("-", "/")}",
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.normal),    
            )
          ],
        ),
      ),
    );
  }
}
