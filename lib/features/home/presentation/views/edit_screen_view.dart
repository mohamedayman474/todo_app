import 'package:flutter/material.dart';
import 'package:todo_app/features/home/presentation/views/widgets/EditScreenViewBody.dart';

import '../view_model/Todo.dart';

class EditScreenView extends StatelessWidget {
  const EditScreenView({super.key, required this.todo});
final Todo todo;


  @override
  Widget build(BuildContext context) {
    return EditScreenViewBody(todo: todo,);
  }
}
