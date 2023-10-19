import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/models/task.dart';
import 'package:todo/myTheme.dart';
import 'package:todo/providers/app_config_provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime dateSelected = DateTime.now();
  var titleController = TextEditingController();
  var desController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late AppConfigProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);

    return Container(
        color: provider.appMode == ThemeMode.light
            ? MyTheme.whiteColor
            : MyTheme.blackColor,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  AppLocalizations.of(context)!.add_new_task,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 20,
                      color: provider.appMode == ThemeMode.light
                          ? MyTheme.blackColor
                          : MyTheme.whiteColor),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.title_required;
                    }
                  },
                  controller: titleController,
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.name_task,
                      hintStyle: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: MyTheme.greyColor, fontSize: 20)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.description_required;
                    }
                  },
                  controller: desController,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.description_task,
                    hintStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: MyTheme.greyColor,
                          fontSize: 20,
                        ),
                  ),
                  maxLines: 3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  AppLocalizations.of(context)!.select_date,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 18,
                      color: provider.appMode == ThemeMode.light
                          ? MyTheme.blackColor
                          : MyTheme.whiteColor),
                ),
              ),
              InkWell(
                onTap: () {
                  showCalendar();
                },
                child: Text(
                  dateSelected.toString().substring(0, 10),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: MyTheme.greyColor,
                        fontSize: 18,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      addTask();
                    }
                  },
                  child: Text(AppLocalizations.of(context)!.add),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: MyTheme.primaryLight),
                ),
              )
            ],
          ),
        ));
  }

  Future<void> showCalendar() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: dateSelected,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 356)));
    if (chosenDate != null) {
      dateSelected = chosenDate;
      setState(() {});
    }
  }

  void addTask() {
    Task task = Task(
        title: titleController.text,
        description: desController.text,
        dateTime: DateUtils.dateOnly(dateSelected).millisecondsSinceEpoch);
    FirebaseUtils.addTaskToFireStore(task).then((value) {
      Navigator.pop(context);
    });
  }
}
