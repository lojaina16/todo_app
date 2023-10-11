import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/myTheme.dart';
import 'package:todo/providers/app_config_provider.dart';

import 'home/homeScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var provider = AppConfigProvider();
  await provider.loadSettingConfig();
  runApp(ChangeNotifierProvider(create: (_) => provider, child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {HomeScreen.routeName: (context) => HomeScreen()},
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: provider.appMode,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.appLanguage),
    );
  }
}
