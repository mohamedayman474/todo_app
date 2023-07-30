import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/features/home/presentation/view_model/Todo.dart';
import 'package:todo_app/features/home/presentation/views/widgets/List/todo_item.dart';

import '../../../view_model/firebase_utils.dart';
import '../../../view_model/provider/AppConfigProvider.dart';

class ListTab extends StatefulWidget {
  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  DateTime selectedDay = DateTime.now();

  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    AppConfigProvider provider = Provider.of(context);
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: TableCalendar(
              firstDay: DateTime.now().subtract(Duration(days: 365)),
              lastDay: DateTime.now().add(Duration(days: 365)),
              focusedDay: focusedDay,
              locale: provider.appLanguage,
              selectedDayPredicate: (day) {
                return isSameDay(selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  this.selectedDay = selectedDay;
                  this.focusedDay =
                      focusedDay; // update `_focusedDay` here as well
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
                        Text(snapshot.error.toString()),
                        ElevatedButton(onPressed: (){
                          setState((){});
                        }, child:  Text('Try Again',style: TextStyle(color: provider.mode== ThemeMode.light ? Colors.black : Colors.white),))
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
                  taskList==null|| taskList.length==0?  Center(child: Text("No tasks for this date",style: TextStyle(color: provider.mode== ThemeMode.light ? Colors.black : Colors.white),))

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
