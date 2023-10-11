import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/app_config_provider.dart';

import '../../myTheme.dart';

class ModeBottomSheet extends StatefulWidget {
  @override
  State<ModeBottomSheet> createState() => _ModeBottomSheetState();
}

class _ModeBottomSheetState extends State<ModeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      color: provider.appMode == ThemeMode.light
          ? MyTheme.whiteColor
          : MyTheme.blackColor,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              provider.changeMode(ThemeMode.light);
            },
            child: provider.appMode == ThemeMode.light
                ? selectedItemWidget(AppLocalizations.of(context)!.light)
                : unSelectedItemWidget(AppLocalizations.of(context)!.light),
          ),
          InkWell(
              onTap: () {
                provider.changeMode(ThemeMode.dark);
              },
              child: provider.appMode == ThemeMode.dark
                  ? selectedItemWidget(AppLocalizations.of(context)!.dark)
                  : unSelectedItemWidget(AppLocalizations.of(context)!.dark))
        ],
      ),
    );
  }

  Widget selectedItemWidget(String txt) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            txt,
            style: Theme.of(context)!
                .textTheme
                .titleMedium!
                .copyWith(fontSize: 20),
          ),
          Icon(
            Icons.check,
            color: MyTheme.primaryLight,
            size: 40,
          )
        ],
      ),
    );
  }

  Widget unSelectedItemWidget(String txt) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            txt,
            style:
                Theme.of(context)!.textTheme.titleSmall!.copyWith(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
