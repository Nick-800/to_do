import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            AppLocalizations localizations = AppLocalizations.of(context)!;

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
               Text(
                localizations.addnewtask,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: widget.titleController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)
                        !.add; //+ "please enter some things ";
                  }

                  if (value.length < 3) {
                    return localizations.please + localizations.entertaskname;
                  }
                  return null;
                },
                decoration:  InputDecoration(
                    hintText: localizations.entertaskname, border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration:  InputDecoration(
                    hintText: localizations.entertasksubtitle ,
                    border: const OutlineInputBorder()),
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
                      child:  Text(
                        localizations.cancel,
                        style: const TextStyle(color: Colors.red),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          widget.onTap();
                        }
                      },
                      child:  Text(localizations.add)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
