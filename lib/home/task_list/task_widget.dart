import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/home/task_list/edit_screen.dart';
import 'package:todo/models/task.dart';
import 'package:todo/myTheme.dart';
import 'package:todo/providers/app_config_provider.dart';

class TaskWidget extends StatefulWidget {
  Task task;

  TaskWidget({required this.task});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        color: provider.appMode == ThemeMode.light
            ? MyTheme.whiteColor
            : MyTheme.blackColorDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Slidable(
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                borderRadius: provider.appLanguage == "en"
                    ? BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        topLeft: Radius.circular(10))
                    : BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(10)),
                onPressed: (context) {
                  //delete task
                  FirebaseUtils.deleteTask(widget.task.id!);
                },
                backgroundColor: MyTheme.redColor,
                foregroundColor: MyTheme.whiteColor,
                icon: Icons.delete,
                label: AppLocalizations.of(context)!.delete,
              ),
              SlidableAction(
                onPressed: (context) {
                  Navigator.pushNamed(context, EditScreen.routeName,
                      arguments: widget.task);
                },
                backgroundColor: Color(0xFF21B7CA),
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: AppLocalizations.of(context)!.edit,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 80,
                  width: 3,
                  color: widget.task.isDone!
                      ? MyTheme.greenColor
                      : MyTheme.primaryLight,
                ),
                //Spacer(),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.task.title ?? "",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: widget.task.isDone!
                                ? MyTheme.greenColor
                                : MyTheme.primaryLight,
                            fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.task.description ?? "",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    )
                  ],
                )),
                widget.task.isDone!
                    ? Text(AppLocalizations.of(context)!.done,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: MyTheme.greenColor))
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: MyTheme.primaryLight,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: InkWell(
                            onTap: () {
                              FirebaseUtils.isDoneTask(widget.task);
                              setState(() {});
                            },
                            child: Icon(
                              Icons.done,
                              color: MyTheme.whiteColor,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
