import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/myTheme.dart';
import 'package:todo/providers/app_config_provider.dart';

class TaskWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              onPressed: (context) {
                //delete task
              },
              backgroundColor: MyTheme.redColor,
              foregroundColor: MyTheme.whiteColor,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete,
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: provider.appMode == ThemeMode.light
                  ? MyTheme.whiteColor
                  : MyTheme.blackColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 80,
                width: 3,
                color: MyTheme.primaryLight,
              ),
              //Spacer(),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppLocalizations.of(context)!.task_title,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: MyTheme.primaryLight, fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppLocalizations.of(context)!.task_description,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  )
                ],
              )),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyTheme.primaryLight,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Icon(
                    Icons.done,
                    color: MyTheme.whiteColor,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
