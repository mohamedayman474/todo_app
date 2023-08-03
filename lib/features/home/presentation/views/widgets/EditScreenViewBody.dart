import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/navigator.dart';
import 'package:todo_app/features/home/presentation/view_model/Todo.dart';
import 'package:todo_app/features/home/presentation/view_model/firebase_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../core/utils/format_date.dart';

class EditScreenViewBody extends StatefulWidget{
  const EditScreenViewBody({super.key, required this.todo});
  final Todo todo;

  @override
  State<EditScreenViewBody> createState() => _EditScreenViewBodyState();
}

class _EditScreenViewBodyState extends State<EditScreenViewBody> {
  String title='';

  String description='';

  DateTime selectedDate=DateTime.now();

  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
      title: Text(AppLocalizations.of(context)!.to_do_list),
      toolbarHeight: MediaQuery
          .of(context)
          .size
          .height * 0.2,
    ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            height: MediaQuery.of(context).size.height*0.1,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            margin: EdgeInsets.all(MediaQuery.of(context).size.height*0.03),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
            ),
            height: MediaQuery.of(context).size.height*0.8,
            width: MediaQuery.of(context).size.width*1,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10,),
                  Text(AppLocalizations.of(context)!.edit_task, textAlign: TextAlign.center,
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleMedium?.copyWith(color: Colors.black),),
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8),
                            child: TextFormField(
                              initialValue: widget.todo.title,
                              decoration:   InputDecoration(
                                labelText: AppLocalizations.of(context)!.title,

                              ),
                              onChanged: (text){
                               widget.todo.title=text;
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
                              initialValue: widget.todo.description,
                              decoration:  InputDecoration(
                                labelText: AppLocalizations.of(context)!.description, ),
                              onChanged: (text){
                                widget.todo.description=text;
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
                    width: double.infinity,

                    margin: const EdgeInsets.all(20),
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
                        child: Text((formatDate('yyyy-MM-dd', widget.todo.dateTime)), style: Theme
                            .of(context)
                            .textTheme
                            .titleMedium?.copyWith(color: Colors.black),
                          textAlign: TextAlign.center,),
                      ),
                    ),
                  ),




                  ElevatedButton(
                      onPressed: (){
                        editTask();
                        hideLoadingDialog(context);

                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                        shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))
                        ))
                      ),
                      child: Text(AppLocalizations.of(context)!.save_changes,style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(color: Colors.white),)),


                ],
              ),
            ),
          ),
        ],
      ),

    );

  }

  void showMyDatePicker() async {
    await showDatePicker(context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365))).then((date) {
      if (date != null) {
        widget.todo.dateTime = date;
        setState(() {

        });
      }
    });
  }

  void editTask() {
    editTaskDetails(widget.todo).then((value) {
    });
  }
}
