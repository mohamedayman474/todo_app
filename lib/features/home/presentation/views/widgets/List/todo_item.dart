import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/app_router.dart';
import 'package:todo_app/core/utils/my_theme_data.dart';
import 'package:todo_app/features/home/presentation/view_model/Todo.dart';
import 'package:todo_app/features/home/presentation/view_model/provider/AppConfigProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/features/home/presentation/views/edit_screen_view.dart';
import '../../../../../../core/utils/navigator.dart';
import '../../../view_model/firebase_utils.dart';

class TodoItem extends StatelessWidget {
  Todo todo;

TodoItem(this.todo, {super.key});

  @override
  Widget build(BuildContext context) {
    AppConfigProvider provider=Provider.of(context);
    return  Slidable(
      closeOnScroll: true,
        startActionPane: ActionPane(
          extentRatio: 0.25,
        motion: const ScrollMotion(),

    children:  [
    Expanded(
        child: InkWell(
          onTap: (){
            onDeleteAction(context);
          },
          child: Container(

            margin: const EdgeInsets.symmetric(vertical: 8),
            height: MediaQuery.of(context).size.height*0.13,
            decoration: const BoxDecoration(
              color: Colors.red,
            ),

      child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Icon(Icons.delete,color: Colors.white,size: 30,),
            Text(AppLocalizations.of(context)!.delete,style: const TextStyle(color: Colors.white,fontSize: 15),)
          ],
      ),
    ),
        ))
    ]
        ),
      child: InkWell(
        onTap: (){
          GoRouter.of(context).push(AppRouter.kEditScreenView,extra: todo);
        },
        child: Container(
          height: MediaQuery.of(context).size.height*0.13,
          margin: const EdgeInsets.symmetric(vertical: 12,horizontal: 8),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(color: provider.mode == ThemeMode.light
          ? Colors.white
              : const Color(0xff141922),
              borderRadius: BorderRadius.circular(12)
          ),

          child: Row(
            children: [
              Container(
                width: 6,
                color: todo.isDone ? MyThemeData.greenColor: Theme.of(context).primaryColor,

              ),
              const Spacer(),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(todo.title,style:todo.isDone? const TextStyle(
                color: MyThemeData.greenColor,fontSize: 18,fontWeight: FontWeight.bold
              ): Theme.of(context).textTheme.titleMedium,),
                  const SizedBox(height: 9,),
                  Expanded(
                    child: Text(todo.description ,style:todo.isDone? const TextStyle(
                    color: MyThemeData.greenColor,fontSize: 15
                    ):  Theme.of(context).textTheme.titleSmall?.
                    copyWith(fontWeight: FontWeight.normal),),
                  )
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: (){
                  editIsDone(todo);
                },
                child: todo.isDone ?
    Container(
    margin: const EdgeInsets.all(12),
    child:  Text(AppLocalizations.of(context)!.done,style:const TextStyle(color: MyThemeData.greenColor,fontSize: 22,fontWeight: FontWeight.bold )),
    ):
                  Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(12)
                      ),

                      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                      child: const Icon(Icons.check,color: Colors.white,)),
              ),


            ],

          ),
        ),
      ),
    );
  }

  void onDeleteAction(BuildContext context) {
    showMessage(context, 'Are yoy sure to want to delete this task',
        'Yes', () {
          deleteTodo(todo)
              .then((value) {

          })
              .catchError((error){

          }).timeout(const Duration(milliseconds:500 ),onTimeout: (){
            GoRouter.of(context).pop();
          });
        },negActionName: 'Cancel',negActionCallBack: (){

        });
  }
}
