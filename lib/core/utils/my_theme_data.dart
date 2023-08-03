import 'dart:ui';

import 'package:flutter/material.dart';

class MyThemeData{
  static const Color _primaryColorLight = Color(0xff5D9CEC);
  static const Color _accentColorLight=Color(0xffDFECDB);
  static const Color _primaryColorDark= Color(0xff5D9CEC);
  static const Color _accentColorDark= Color(0xff060E1E);
  static const Color greenColor= Color(0xff61E757);


  static ThemeData lightTheme=ThemeData(
    primaryColor: MyThemeData._primaryColorLight,
    scaffoldBackgroundColor: _accentColorLight,
    appBarTheme: const AppBarTheme(elevation: 0,
        color: _primaryColorLight,

        titleTextStyle: TextStyle(color: Colors.white,
            fontSize: 22,fontWeight: FontWeight.bold)),
    textTheme: const TextTheme(titleSmall: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),
    titleMedium: TextStyle(color: _primaryColorLight,fontSize: 18,fontWeight: FontWeight.bold),
    titleLarge: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),

    )

  );
  static ThemeData darkTheme=ThemeData(
      primaryColor: MyThemeData._primaryColorDark,
      scaffoldBackgroundColor: _accentColorDark,
      appBarTheme: const AppBarTheme(elevation: 0,
          color: _primaryColorDark,
          titleTextStyle: TextStyle(color: Colors.black,
              fontSize: 22,fontWeight: FontWeight.bold)),
      textTheme: const TextTheme(titleSmall: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: _primaryColorLight,fontSize: 18,fontWeight: FontWeight.bold),
        titleLarge: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
      )

  );

}