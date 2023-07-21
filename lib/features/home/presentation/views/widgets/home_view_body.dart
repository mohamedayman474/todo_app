import 'package:flutter/material.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List'),
        toolbarHeight: MediaQuery.of(context).size.height * 0.2,
      ),
      floatingActionButton: FloatingActionButton(
        shape: const StadiumBorder(
            side: BorderSide(width: 4, color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        notchMargin: 8,
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(label: 'list', icon: Icon(Icons.list)),
            BottomNavigationBarItem(
                label: 'settings', icon: Icon(Icons.settings)),
          ],
        ),
      ),
    );
  }
}
