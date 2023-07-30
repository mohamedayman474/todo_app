import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/features/home/presentation/view_model/Todo.dart';
import 'package:todo_app/features/home/presentation/view_model/provider/AppConfigProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../core/utils/navigator.dart';
import '../../../view_model/firebase_utils.dart';

class TodoItem extends StatefulWidget {
  Todo todo;

TodoItem(this.todo, {super.key});

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
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
            onDeleteAction();
          },
          child: Container(
            height: MediaQuery.of(context).size.height*0.13,
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(topRight: Radius.circular(12),bottomRight: Radius.circular(12))
            ),

      child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Icon(Icons.delete,color: Colors.white,size: 30,),
            Text(AppLocalizations.of(context)!.delete,style: TextStyle(color: Colors.white,fontSize: 15),)
          ],
      ),
    ),
        ))
    ]
        ),
      child: Container(
        height: MediaQuery.of(context).size.height*0.13,
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(color: provider.mode == ThemeMode.light
        ? Colors.white
            : const Color(0xff0c1940),
            borderRadius: BorderRadius.circular(24)
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
                Text(widget.todo.title,style: Theme.of(context).textTheme.titleMedium,),
                const SizedBox(height: 9,),
                Expanded(
                  child: Text(widget.todo.description ,style: Theme.of(context).textTheme.titleSmall?.
                  copyWith(fontWeight: FontWeight.normal),),
                )
              ],
            ),
            const Spacer(),
            Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(12)
                ),

                padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                child: const Icon(Icons.check,color: Colors.white,))

          ],

        ),
      ),
    );
  }

  void onDeleteAction() {
    showMessage(context, 'Are yoy sure to want to delete this task',
        'Yes', () {
          deleteTodo(widget.todo)
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
