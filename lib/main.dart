import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/features/home/presentation/view_model/provider/AppConfigProvider.dart';
import 'core/utils/app_router.dart';
import 'core/utils/my_theme_data.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);

  FirebaseFirestore.instance.settings =
      const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  await FirebaseFirestore.instance.disableNetwork();

  runApp(ChangeNotifierProvider(
          create: (_) => AppConfigProvider(), child: MyApp(),
      ),

  );
}

class MyApp extends StatelessWidget {
  late AppConfigProvider provider;
  late SharedPreferences prefs;

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    initSharedPreference();
    return MaterialApp.router(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('ar'), // arabic
      ],
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      title: 'Flutter Demo',
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      themeMode: provider.mode,
      locale: Locale(provider.appLanguage),
    );
  }

  void initSharedPreference() async {
    prefs = await SharedPreferences.getInstance();
    provider.setNewLanguage(prefs.getString('language') ?? 'en');
    if (prefs.getString('theme') == 'light') {
      provider.setNewMode(ThemeMode.light);
    } else if (prefs.getString('theme') == 'dark') {
      provider.setNewMode(ThemeMode.dark);
    }
  }
}
