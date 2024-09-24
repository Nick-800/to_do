import 'package:flutter/material.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog(
      {super.key,
      required this.titleController,
      required this.subTitleController,
      required this.onTap});
  final TextEditingController titleController;
  final TextEditingController subTitleController;
  final Function onTap;
  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Add New Task",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: widget.titleController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Task Title";
                  }

                  if (value.length < 3) {
                    return "Please Enter Valid Task Title";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    hintText: "Enter Title Here!",
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    hintText: "Enter Subtitle Here!",
                    border: OutlineInputBorder()),
                controller: widget.subTitleController,
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        widget.titleController.clear();
                        widget.subTitleController.clear();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.red),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          widget.onTap();
                        }
                      },
                      child: const Text("ADD")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
