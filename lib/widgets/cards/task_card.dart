import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/providers/dark_mode_provider.dart';
import 'package:to_do/screens/task_details_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.taskModel, required this.onTap});
  final TaskModel taskModel;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeProvider>(builder: (context, darkModeConsumer, _) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => TaskDetailsScreen(
                        taskModel: taskModel,
                      )));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: darkModeConsumer.isDark
                      ? Colors.white12
                      : Colors.blue.withOpacity(0.1)),
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
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: darkModeConsumer.isDark
                                  ? Colors.white
                                  : Colors.blueGrey),
                        ),
                        if (taskModel.subTitle != null)
                          Text(
                            taskModel.subTitle!,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: darkModeConsumer.isDark
                                    ? Colors.white
                                    : Colors.blueGrey),
                          ),
                        Text(
                          taskModel.isCompleted
                              ? DateFormat("EEE-dd-MMM-yyyy")
                                  .format(DateTime.parse(taskModel.createdAt))
                                  .replaceAll("-", ", ")
                              : format(DateTime.parse(taskModel.createdAt)),
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: darkModeConsumer.isDark
                                  ? Colors.white38
                                  : Colors.blueGrey.withOpacity(0.5)),
                        )
                      ],
                    ),
                    Checkbox(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                      side: WidgetStateBorderSide.resolveWith(
                        (states) => BorderSide(
                            width: 1.0,
                            color: darkModeConsumer.isDark
                                ? Colors.white
                                : Colors.blueGrey),
                      ),
                      checkColor:
                          darkModeConsumer.isDark ? Colors.white : Colors.white,
                      value: taskModel.isCompleted,
                      onChanged: (check) {
                        onTap();
                      },
                    ),
                  ],
                ),
              )),
        ),
      );
    });
  }
}
