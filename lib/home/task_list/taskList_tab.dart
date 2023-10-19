import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/home/task_list/task_widget.dart';
import 'package:todo/models/task.dart';
import 'package:todo/myTheme.dart';
import 'package:todo/providers/app_config_provider.dart';

class TaskListTab extends StatefulWidget {
  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return Column(
      children: [
        CalendarTimeline(
          initialDate: selectedDate,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) {
            changeDate(date);
          },
          leftMargin: 20,
          monthColor: provider.appMode == ThemeMode.light
              ? MyTheme.blackColor
              : MyTheme.whiteColor,
          dayColor: provider.appMode == ThemeMode.light
              ? MyTheme.blackColor
              : MyTheme.whiteColor,
          activeDayColor: MyTheme.whiteColor,
          activeBackgroundDayColor: MyTheme.primaryLight,
          dotsColor: MyTheme.whiteColor,
          selectableDayPredicate: (date) => true,
          locale: 'en_ISO',
        ),
        Expanded(
            child: StreamBuilder<QuerySnapshot<Task>>(
          stream: FirebaseUtils.getTasks(selectedDate),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            var tasks =
                snapshot.data?.docs.map((doc) => doc.data()).toList() ?? [];
            return ListView.builder(
              itemBuilder: (context, index) {
                return TaskWidget(task: tasks[index]);
              },
              itemCount: tasks.length,
            );
          },
        )),
      ],
    );
  }

  void changeDate(DateTime newDate) {
    selectedDate = newDate;
    FirebaseUtils.getTasks(newDate);
    setState(() {});
  }
}
