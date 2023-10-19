import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task.dart';
import 'package:todo/providers/app_config_provider.dart';

import '../../firebase_utils.dart';
import '../../myTheme.dart';

class EditScreen extends StatefulWidget {
  static const String routeName = "Edit screen";

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  Task? arg;
  var titleController = TextEditingController();
  var descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (arg == null) {
      arg = ModalRoute.of(context)!.settings.arguments as Task;
      titleController.text = arg!.title ?? "";
      descController.text = arg!.description ?? "";
      selectedDate = DateTime.fromMillisecondsSinceEpoch(arg!.dateTime!);
    }
    double height = MediaQuery.of(context).size.height;
    var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
      backgroundColor: provider.appMode == ThemeMode.light
          ? MyTheme.backgroundLight
          : MyTheme.backgroundDark,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.todo_list,
            style: Theme.of(context).textTheme.titleLarge),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: provider.appMode == ThemeMode.light
                ? MyTheme.whiteColor
                : MyTheme.blackColorDark),
        padding: EdgeInsets.all(50),
        margin: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppLocalizations.of(context)!.edit_task,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 20,
                      color: provider.appMode == ThemeMode.light
                          ? MyTheme.blackColor
                          : MyTheme.whiteColor),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.title_required;
                      }
                    },
                    controller: titleController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.name_task,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: MyTheme.greyColor, fontSize: 20)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!
                            .description_required;
                      }
                    },
                    controller: descController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.description_task,
                      hintStyle:
                          Theme.of(context).textTheme.titleLarge!.copyWith(
                                color: MyTheme.greyColor,
                                fontSize: 20,
                              ),
                    ),
                    maxLines: 3,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.select_date,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 18,
                      color: provider.appMode == ThemeMode.light
                          ? MyTheme.blackColor
                          : MyTheme.whiteColor),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: InkWell(
                    onTap: () {
                      showCalendar();
                    },
                    child: Text(
                      DateFormat.MEd().format(selectedDate),
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: MyTheme.greyColor,
                            fontSize: 18,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      editTask();
                    }
                  },
                  child: Text(AppLocalizations.of(context)!.save),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      backgroundColor: MyTheme.primaryLight),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showCalendar() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 356)));
    if (chosenDate != null) {
      selectedDate = chosenDate;
      setState(() {});
    }
  }

  void editTask() {
    arg!.title = titleController.text;
    arg!.description = descController.text;
    arg!.dateTime = selectedDate.millisecondsSinceEpoch;

    FirebaseUtils.updateTask(arg!).then((value) {
      Navigator.pop(context);
    });
  }
}
