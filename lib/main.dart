import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/app_router.dart';
import 'package:todo_app/core/utils/my_theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      title: 'Flutter Demo',
      theme: MyThemeData.lightTheme,

    );
  }
}
