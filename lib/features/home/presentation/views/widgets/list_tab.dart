import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ListTab extends StatefulWidget {
  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  DateTime selectedDay = DateTime.now();

  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: TableCalendar(
              firstDay: DateTime.now().subtract(Duration(days: 365)),
              lastDay: DateTime.now().add(Duration(days: 365)),
              focusedDay: focusedDay,
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
          child: ListView.builder(
              itemCount:10 ,
              itemBuilder: (context,index){
                return Container(
                    height: MediaQuery.of(context).size.height*0.13,
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(color: Colors.white
                  ,borderRadius: BorderRadius.circular(24)
                  ),
                  
                  child: Row(
                    children: [
                      Container(
                        width: 6,
                        color: Theme.of(context).primaryColor,
                        
                      ),
                      const Spacer(),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Play basketball',style: Theme.of(context).textTheme.titleMedium,),
                          const SizedBox(height: 9,),
                          Row(
                            children: [
                              const Icon(Icons.timelapse_outlined,size: 22,),
                              const SizedBox(width: 7,),
                              Text('10 : 30 pm ',style: Theme.of(context).textTheme.titleSmall?.
                             copyWith(fontWeight: FontWeight.normal),)
                            ],
                          )
                        ],
                      ),
                      const Spacer(flex: 3,),
                      Container(
                          decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(12)
                      ),
                          
                          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                          child: const Icon(Icons.check,color: Colors.white,))

                  ],

                  ),
                );

          }),
        )
        
      ],
    );
  }
}
