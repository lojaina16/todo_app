import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/home/settings/mode_bottom_sheet.dart';
import 'package:todo/myTheme.dart';
import 'package:todo/providers/app_config_provider.dart';

import 'language_bottom_sheet.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(AppLocalizations.of(context)!.language,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        InkWell(
          onTap: () {
            showLanguageBottomSheet();
          },
          child: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: MyTheme.primaryLight),
                color: provider.appMode == ThemeMode.light
                    ? MyTheme.whiteColor
                    : MyTheme.blackColorDark,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                        provider.appLanguage == "en"
                            ? AppLocalizations.of(context)!.english
                            : AppLocalizations.of(context)!.arabic,
                        style: Theme.of(context)!.textTheme.titleMedium),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: MyTheme.primaryLight,
                  )
                ],
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(AppLocalizations.of(context)!.mode,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        InkWell(
          onTap: () {
            showModeBottomSheet();
          },
          child: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: MyTheme.primaryLight),
                color: provider.appMode == ThemeMode.light
                    ? MyTheme.whiteColor
                    : MyTheme.blackColorDark,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                        provider.appMode == ThemeMode.light
                            ? AppLocalizations.of(context)!.light
                            : AppLocalizations.of(context)!.dark,
                        style: Theme.of(context)!.textTheme.titleMedium),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: MyTheme.primaryLight,
                  )
                ],
              )),
        )
      ],
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => LanguageBottomSheet());
  }

  void showModeBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => ModeBottomSheet());
  }
}
