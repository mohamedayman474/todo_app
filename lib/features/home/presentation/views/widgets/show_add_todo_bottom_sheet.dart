

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_model/provider/AppConfigProvider.dart';
import 'add_task_bottom_sheet.dart';

void showAddTodoBottomSheet(BuildContext context) {
  AppConfigProvider provider = Provider.of(context,listen: false);
  showModalBottomSheet(
    backgroundColor: provider.mode==ThemeMode.light? Colors.white:const Color(0xff141922),
      context: context,
      builder: (context){
        return  const AddTaskBottomSheet();
      });
}


