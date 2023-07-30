import 'package:flutter/material.dart';
import 'package:todo_app/features/home/presentation/views/widgets/settings/settings_tab.dart';
import 'package:todo_app/features/home/presentation/views/widgets/show_add_todo_bottom_sheet.dart';

import 'List/list_tab.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  int selectedIndex = 0;

  List<Widget> tabs = [
    ListTab(), SettingsTab()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List'),
        toolbarHeight: MediaQuery
            .of(context)
            .size
            .height * 0.2,
      ),
      floatingActionButton: FloatingActionButton(
        shape: const StadiumBorder(
            side: BorderSide(width: 4, color: Colors.white)),
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        onPressed: () {
          showAddTodoBottomSheet(context);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(

        shape: const CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        notchMargin: 8,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            setState(() {

            });
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(label: 'list', icon: Icon(Icons.list)),
            BottomNavigationBarItem(
                label: 'settings', icon: Icon(Icons.settings)),
          ],
        ),
      ),
      body: tabs[selectedIndex],
    );
  }
}

