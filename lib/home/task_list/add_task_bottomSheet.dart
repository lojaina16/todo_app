import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/myTheme.dart';
import 'package:todo/providers/app_config_provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var titleController = TextEditingController();
    var desController = TextEditingController();
    return Container(
        color: provider.appMode == ThemeMode.light
            ? MyTheme.whiteColor
            : MyTheme.blackColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                AppLocalizations.of(context)!.add_new_task,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 20, color: MyTheme.whiteColor),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: TextFormField(
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
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 18, color: MyTheme.whiteColor),
              ),
            ),
            InkWell(
              onTap: () {
                showCalendar();
              },
              child: Text(
                selectedDate.toString().substring(0, 10),
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
                onPressed: () {},
                child: Text(AppLocalizations.of(context)!.add),
                style: ElevatedButton.styleFrom(
                    backgroundColor: MyTheme.primaryLight),
              ),
            )
          ],
        ));
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
}
