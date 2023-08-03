import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/my_theme_data.dart';
import 'package:todo_app/features/home/presentation/views/widgets/settings/settings_tab.dart';
import 'package:todo_app/features/home/presentation/views/widgets/show_add_todo_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../view_model/provider/AppConfigProvider.dart';
import 'List/list_tab.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  int selectedIndex = 0;

  List<Widget> tabs = [
    ListTab(), const SettingsTab()
  ];

  @override
  Widget build(BuildContext context) {
    AppConfigProvider provider=Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title:  Text(AppLocalizations.of(context)!.to_do_list),
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
      bottomNavigationBar:
      Theme(

        data: Theme.of(context).copyWith(canvasColor:provider.mode==ThemeMode.light? Colors.white:const Color(0xff141922)),
        child: BottomAppBar(
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
            items:  [
              BottomNavigationBarItem(label: AppLocalizations.of(context)!.list, icon: const Icon(Icons.list)),
              BottomNavigationBarItem(
                  label: AppLocalizations.of(context)!.settings, icon: const Icon(Icons.settings)),
            ],
          ),
        ),
      ),
      body: tabs[selectedIndex],
    );
  }
}

