import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/utils/format_date.dart';
import 'package:todo_app/core/utils/navigator.dart';

import '../../view_model/Todo.dart';
import '../../view_model/firebase_utils.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const  AddTaskBottomSheet({super.key});


  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
 String title='';

  String description='';

  DateTime selectedDate=DateTime.now();
 final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Spacer(),
      Text("Add New Task", textAlign: TextAlign.center,
      style: Theme
          .of(context)
          .textTheme
          .titleMedium?.copyWith(color: Colors.black),),
        Spacer(),
        Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                TextFormField(
                  decoration:  const InputDecoration(
                    labelText: "Title",

                  ),
                  onChanged: (text){
                    title=text;
                  },
                  validator: (text){
                    if(text==null || text.isEmpty){
                      return "Enter title here";
                    }
                    return null;
                  },

                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Description", ),
                  onChanged: (text){
                    description=text;
                  },
                  validator: (text){
                    if(text==null || text.isEmpty){
                      return "Enter description here";
                    }
                    return null;
                  },
                  maxLines: 3,
                  minLines: 3,



                ),

              ],
            ),
          ),
        ),

        Container(

          margin: EdgeInsets.all(12),
          child: Text("Select time", style: Theme
              .of(context)
              .textTheme
              .titleLarge,),
        ),
        InkWell(
          onTap: () {},

          child: Opacity(
            opacity: 0.6,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              child: InkWell(
                onTap: (){
                  showMyDatePicker();

                },
                child: Text((formatDate('yyyy-MM-dd', selectedDate)), style: Theme
                    .of(context)
                    .textTheme
                    .titleMedium?.copyWith(color: Colors.black),
                  textAlign: TextAlign.center,),
              ),
            ),
          ),
        ),

       ElevatedButton(
           onPressed: (){
             addTask();
           },
          child: Text('Add task',style: Theme.of(context).textTheme.titleMedium
        ?.copyWith(color: Colors.white),)),


      ]
      ),
    );
  }
 void addTask(){

   if(formKey.currentState?.validate()==true){
     Todo todo=Todo(title: title, description: description,
         dateTime: DateUtils.dateOnly(selectedDate).millisecondsSinceEpoch);
     addTaskToFirestore(todo).then((value) {
       hideLoadingDialog(context);
       showMessage(context, 'Task Added Successfully', 'Ok', () {

       });
     }).catchError((error){
       hideLoadingDialog(context);
       showMessage(context, "Error can't add task "
           "please try again later  ", 'Ok', () {

       });
     }).timeout(const Duration(milliseconds:500 ),onTimeout: (){
       GoRouter.of(context).pop();
     });



   }



 }
 void showMyDatePicker() async{

   DateTime? newDate=  await showDatePicker(context: context,
       initialDate: selectedDate,
       firstDate: DateTime.now(),
       lastDate: DateTime.now().add(const Duration(days: 365)));
   selectedDate= newDate == null ? selectedDate : newDate;
   setState(() {

   });

 }
}
