import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


void showMessage(BuildContext context, String message, String actionName,
    VoidCallback actionCallBack,
    {String? negActionName, VoidCallback? negActionCallBack}) {
  showDialog(
      context: context,
      builder: (context) {
        List<Widget> actions = [
          TextButton(
              onPressed: () {
                GoRouter.of(context).pop();
                actionCallBack();
              },
              child: Text(actionName))
        ];
        if (negActionName != null) {
          actions.add(TextButton(
              onPressed: () {
                GoRouter.of(context).pop();
                if(negActionCallBack!=null) {
                  negActionCallBack();

                }
              },
              child: Text(negActionName)));
        }

        return AlertDialog(
          content: Text(message),
          actions: actions,
        );
      });
}

void showLoading(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                const CircularProgressIndicator(),
                const SizedBox(
                  width: 20,
                ),
                Text(message),
              ],
            ),
          ),
        );
      });
}

void hideLoadingDialog(BuildContext context) {
  GoRouter.of(context).pop();
}