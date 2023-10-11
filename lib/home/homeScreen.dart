import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/home/settings/settings_tab.dart';
import 'package:todo/home/task_list/add_task_bottomSheet.dart';
import 'package:todo/home/task_list/taskList_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.todo_list,
              style: Theme.of(context).textTheme.titleLarge)),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "")
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskBottomSheet();
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[selectedIndex],
    );
  }

  List<Widget> tabs = [TaskListTab(), SettingsTab()];

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: AddTaskBottomSheet(),
            ));
  }
}
