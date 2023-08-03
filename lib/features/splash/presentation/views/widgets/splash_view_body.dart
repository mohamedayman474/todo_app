import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../home/presentation/view_model/provider/AppConfigProvider.dart';


class SplashViewBody extends StatefulWidget {
  const SplashViewBody({Key? key}) : super(key: key);

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    super.initState();
    navigateToHome();
  }
  @override
  Widget build(BuildContext context) {
    AppConfigProvider provider=Provider.of(context);
    return Scaffold(
        body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(provider.mode==ThemeMode.light? AssetsData.splash: AssetsData.darkSplash,fit: BoxFit.fill,)
        )
    );
  }

  void navigateToHome(){
    Future.delayed(const Duration(seconds: 2),(){
      GoRouter.of(context).pushReplacement(AppRouter.kHomeView);

    });
  }
}