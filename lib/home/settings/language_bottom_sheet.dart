import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/myTheme.dart';
import 'package:todo/providers/app_config_provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
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
              provider.changeLanguage("en");
            },
            child: provider.appLanguage == "en"
                ? selectedItemWidget(AppLocalizations.of(context)!.english)
                : unSelectedItemWidget(AppLocalizations.of(context)!.english),
          ),
          InkWell(
            onTap: () {
              provider.changeLanguage("ar");
            },
            child: provider.appLanguage == "ar"
                ? selectedItemWidget(AppLocalizations.of(context)!.arabic)
                : unSelectedItemWidget(AppLocalizations.of(context)!.arabic),
          )
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
