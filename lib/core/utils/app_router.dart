import 'package:go_router/go_router.dart';
import 'package:todo_app/features/home/presentation/view_model/Todo.dart';
import 'package:todo_app/features/home/presentation/views/edit_screen_view.dart';

import '../../features/home/presentation/views/home_view.dart';
import '../../features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const kHomeView = '/home';
  static const kEditScreenView = '/edit';
  static final router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: kHomeView,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: kEditScreenView,
      builder: (context, state) =>   EditScreenView(todo: state.extra as Todo,),
    ),
  ]);
}
