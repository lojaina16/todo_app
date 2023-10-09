import 'package:flutter/material.dart';
import 'package:todo/myTheme.dart';

import 'home/homeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {HomeScreen.routeName: (context) => HomeScreen()},
      theme: MyTheme.lightTheme,
    );
  }
}
