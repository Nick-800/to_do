import 'package:flutter/material.dart';
import 'package:to_do/models/task_model.dart';

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
          centerTitle: true,
          title: const Text("Task Details"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: double.infinity,
                height: 100,
              ),
              Text(
                "Title : ${widget.taskModel.title}",
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              if (widget.taskModel.subTitle != null)
                Text(
                  "Subtitle : ${widget.taskModel.subTitle}",
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.normal),
                ),
              Icon(
                  widget.taskModel.isCompleted
                      ? Icons.check
                      : Icons.cancel_outlined,
                  size: 200,
                  color:
                      widget.taskModel.isCompleted ? Colors.green : Colors.red),
              Text(
                "Craeted At : ${widget.taskModel.createdAt.toString().substring(0, 10).replaceAll("-", ",")}",
                style: const TextStyle(
                    fontSize: 26, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                width: double.infinity,
                height: 100,
              ),
            ],
          ),
        ));
  }
}
