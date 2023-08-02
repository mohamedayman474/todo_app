import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/utils/format_date.dart';
import 'package:todo_app/core/utils/navigator.dart';
import '../../view_model/Todo.dart';
import '../../view_model/firebase_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(12),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10,),
        Text(AppLocalizations.of(context)!.add_new_task, textAlign: TextAlign.center,
        style: Theme
            .of(context)
            .textTheme
            .titleMedium?.copyWith(color: Colors.black),),

          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: TextFormField(
                      decoration:   InputDecoration(
                        labelText: AppLocalizations.of(context)!.title,

                      ),
                      onChanged: (text){
                        title=text;
                      },
                      validator: (text){
                        if(text==null || text.isEmpty){
                          return AppLocalizations.of(context)!.enter_title_here;
                        }
                        return null;
                      },

                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: TextFormField(
                      decoration:  InputDecoration(
                        labelText: AppLocalizations.of(context)!.description, ),
                      onChanged: (text){
                        description=text;
                      },
                      validator: (text){
                        if(text==null || text.isEmpty){
                          return AppLocalizations.of(context)!.enter_description_here;
                        }
                        return null;
                      },
                      maxLines: 3,
                      minLines: 3,



                    ),
                  ),

                ],
              ),
            ),
          ),

          Container(

            margin: const EdgeInsets.all(18),
            child: Text(AppLocalizations.of(context)!.select_time, style: Theme
                .of(context)
                .textTheme
                .titleLarge,),
          ),
          Opacity(
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

         ElevatedButton(
             onPressed: (){
               addTask();

             },
             style: ButtonStyle(
                 backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                 shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                     borderRadius: BorderRadius.all(Radius.circular(25))
                 ))
             ),
            child: Text(AppLocalizations.of(context)!.add_task,style: Theme.of(context).textTheme.titleMedium
          ?.copyWith(color: Colors.white),)),


        ]
        ),
      ),
    );
  }
 void addTask(){

   if(formKey.currentState?.validate()==true){
     Todo todo=Todo(title: title, description: description,
         dateTime: DateUtils.dateOnly(selectedDate));
     addTaskToFirestore(todo).then((value) {
       hideLoadingDialog(context);
       showMessage(context, AppLocalizations.of(context)!.task_added_successfully, AppLocalizations.of(context)!.ok, () {

       });
     }).catchError((error){
       hideLoadingDialog(context);
       showMessage(context, AppLocalizations.of(context)!.error_can_not_add_task_please_try_again_later  , AppLocalizations.of(context)!.ok, () {

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
