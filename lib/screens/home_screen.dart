import 'package:flutter/material.dart';
import 'package:to_do/models/task_models.dart';
import 'package:to_do/providers/tasks_Provider.dart';
import 'package:to_do/widgets/cards/taskcard.dart';
import 'package:to_do/widgets/dialogs/addtaddialog.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController subTaskTitleController = TextEditingController();
  // List<TaskModel> tasks = [];

  @override
  void initState() {
    print("thisFunWorks");
    Provider.of<TasksProvider>(context,listen: false).getTasks();
    print(Provider.of<TasksProvider>(context,listen: false).tasks);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<TasksProvider>(
      builder: (context, tasksProvider,_) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AddTaskDialog(
                          taskTitleController: taskTitleController,
                          taskSubtitleController: subTaskTitleController,
                          formkey: formKey,
                          ontap: () {
                            Provider.of<TasksProvider>(context , listen: false).addTask(
                              TaskModel(
                                title: taskTitleController.text,
                                subTitle: subTaskTitleController.text,
                                createdAt: DateTime.now())
                            ) ; 
                            taskTitleController.clear();
                            subTaskTitleController.clear();
                            Navigator.pop(context);
                          });
                    });
              }),
          appBar: AppBar(
            title: const Text("ToDo"),
          ),
          body:  DefaultTabController(
          length: 2,
          child: Column(
            children: [
              const  TabBar(tabs: [
                Tab(text:"Waiting"),
                Tab(text: "Completed",)
              ]),
              Expanded(child: TabBarView(children: [
                ListView.builder(
                  padding: const EdgeInsets.all(24),
                  itemCount:tasksProvider.tasks.length,
                  itemBuilder: (context, index){
                    if (!tasksProvider.tasks[index].status){
                    return  TaskCard(taskModel: tasksProvider.tasks[index], onTapForCheck:(){
                        Provider.of<TasksProvider>(context,listen: false).switchState(
                          tasksProvider.tasks[index]
                        );
                      },
                      onTapForDelete: () {
                          Provider.of<TasksProvider>(context,listen: false).deleteTask(
                            tasksProvider.tasks[index]
                          );
                        },
                        onTapForEdite: (){
                          showDialog(context: context, builder: (context) {
                            return AddTaskDialog(
                              textOnButton: "Edit",
                              textOnDia: "Edit your task",
                              taskTitleController: taskTitleController,
                              taskSubtitleController: subTaskTitleController,
                              formkey: formKey,
                              ontap: (){
                                Provider.of<TasksProvider>(context , listen: false).editTask(
                                TaskModel(
                                title: taskTitleController.text,
                                subTitle: subTaskTitleController.text,
                                createdAt: DateTime.now()),tasksProvider.tasks[index]);
                                      taskTitleController.clear();
                                      subTaskTitleController.clear();
                                      Navigator.pop(context);

                            });
                          },);
                        },
                      );
                      
                      }
                    else {return const SizedBox();} 
                  },
                  ),
                  ListView.builder(
                      padding: const EdgeInsets.all(24),
                      itemCount: tasksProvider.tasks.length,
                      itemBuilder: (context, index) {
                        if (tasksProvider.tasks[index].status) {
                          return TaskCard(
                              taskModel: tasksProvider.tasks[index],
                              onTapForCheck: () {
                                Provider.of<TasksProvider>(context,listen: false).switchState(
                                tasksProvider.tasks[index]
                              );
                              },
                              onTapForDelete: (){
                                Provider.of<TasksProvider>(context, listen: false)
                                .deleteTask(tasksProvider.tasks[index]);
                              },
                              onTapForEdite: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AddTaskDialog(
                                      textOnButton: "Edit",
                                      textOnDia: "Edit your task",
                                      taskTitleController: taskTitleController,
                                      taskSubtitleController:
                                          subTaskTitleController,
                                      formkey: formKey,
                                      ontap: () {
                                        Provider.of<TasksProvider>(context,
                                                listen: false)
                                            .editTask(
                                                TaskModel(
                                                  status: true,
                                                    title: taskTitleController
                                                        .text,
                                                    subTitle:
                                                        subTaskTitleController
                                                            .text,
                                                    createdAt: DateTime.now()),
                                                tasksProvider.tasks[index]);
                                        taskTitleController.clear();
                                        subTaskTitleController.clear();
                                        Navigator.pop(context);
                                      });
                                },
                              );
                            }
                              );
                        } else {
                          return const SizedBox();
                        }
                      },
                    )
                
              ]))
            ],
          )
          ),
        );
      }
    );
  }
}

