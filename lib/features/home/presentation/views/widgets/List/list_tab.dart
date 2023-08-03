import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/features/home/presentation/view_model/Todo.dart';
import 'package:todo_app/features/home/presentation/views/widgets/List/todo_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../view_model/firebase_utils.dart';
import '../../../view_model/provider/AppConfigProvider.dart';

class ListTab extends StatefulWidget {
  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  List<Todo> taskList=[];
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    AppConfigProvider provider = Provider.of(context);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          color: Colors.white,
          child: TableCalendar(
              firstDay: DateTime.now().subtract(const Duration(days: 365)),
              lastDay: DateTime.now().add(const Duration(days: 365)),
              focusedDay: focusedDay,
              locale: provider.appLanguage,
              selectedDayPredicate: (day) {
                return isSameDay(selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  this.selectedDay=selectedDay;
                  this.focusedDay = focusedDay;

                });
              },
              headerVisible: false,
              calendarFormat: CalendarFormat.week,
              daysOfWeekHeight: 30,
              daysOfWeekStyle:
                  const DaysOfWeekStyle(decoration: BoxDecoration(color: Colors.white)),
              calendarStyle:   CalendarStyle(
                  isTodayHighlighted: false,
                  holidayDecoration: const BoxDecoration(color: Colors.white),
                  defaultDecoration: const BoxDecoration(color: Colors.white),
                  weekendDecoration: const BoxDecoration(color: Colors.white),
                  selectedDecoration: BoxDecoration(
                      color: Theme.of(context).primaryColor)

              )),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<Todo>>(
              stream: getTasks(DateUtils.dateOnly(selectedDay).millisecondsSinceEpoch),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      children: [
                        Text(AppLocalizations.of(context)!.there_was_an_error_Please_try_again,style: TextStyle(color: provider.mode==ThemeMode.light? Colors.black:Colors.white,fontSize: 18)),
                        ElevatedButton(onPressed: (){
                          setState((){});
                        }, child:  Text(AppLocalizations.of(context)!.try_again,
                            style: TextStyle(color: provider.mode==ThemeMode.light? Colors.black:Colors.white,fontSize: 18)))
                      ],
                    ),
                  );
                }
                var data = snapshot.data;
                var taskList = data?.docs.map((doc) => doc.data()).toList();
                taskList?.sort((Todo a, Todo b){
                  return a.dateTime.compareTo(b.dateTime);

                });
                return
                  taskList==null|| taskList.length==0?
                  Center(child:
                  Text(AppLocalizations.of(context)!.no_tasks_for_this_date,
                    style: TextStyle(color: provider.mode==ThemeMode.light? Colors.black:Colors.white,fontSize: 18)))
                      :ListView.builder(
                      itemCount: (taskList.length),
                      itemBuilder: (context, index) {
                        return TodoItem((taskList.elementAt(index)));
                      });
              }),
        ),
        
      ],
    );
  }


}
