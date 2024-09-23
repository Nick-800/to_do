import 'package:flutter/material.dart';
import 'package:to_do/models/task_models.dart';
import 'package:to_do/screens/task_deatails_screen.dart';
import 'package:to_do/widgets/dialogs/addtaddialog.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart';

class TaskCard extends StatelessWidget {
  TaskCard(
      {super.key,
      required this.taskModel,
      required this.onTapForCheck,
      required this.onTapForDelete, required this.onTapForEdite});
  final TaskModel taskModel;
  final Function onTapForCheck;
  final Function onTapForDelete;
  final Function onTapForEdite;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder:(context) => TaskDetailsScreen(taskModel: taskModel)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.blue.withOpacity(0.2)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      taskModel.title,
                      style: TaskCartTextStyle(18),
                    ),
                    Text(
                      taskModel.subTitle ?? "",
                      style: TaskCartTextStyle(14),
                    ),
                    Text(
                      TaskCardFormatDate(taskModel),
                      style: TaskCartTextStyle(13,
                          fontColor: Colors.blueGrey.withOpacity(0.5)),
                    )
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: (){ 
                          onTapForEdite();
                          },
                          icon: Icon(Icons.edit)),
                    IconButton(
                        onPressed: () {
                          onTapForDelete();
                        },
                        icon: const Icon(Icons.delete)),
                    Checkbox(
                        value: taskModel.status,
                        onChanged: (check) {
                          onTapForCheck();
                        })
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

TextStyle TaskCartTextStyle(double fontSize,
    {FontWeight fontWeight = FontWeight.bold,
    Color fontColor = Colors.blueGrey}) {
  return TextStyle(
      fontSize: fontSize, fontWeight: fontWeight, color: fontColor);
}

String TaskCardFormatDate(TaskModel taskmodel) {
  if (taskmodel.status) {
    return DateFormat("EEE-dd-MMM-yyyy")
        .format(DateTime.parse(taskmodel.createdAt.toIso8601String()))
        .replaceAll("-", ",");
  } else {
    return format(taskmodel.createdAt);
  }
}
