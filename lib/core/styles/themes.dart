import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fr_philopater/core/styles/text_styles.dart';

import 'app_colors.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: false,
  primarySwatch: createMaterialColor(AppColors.primaryColor),
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  fontFamily: myFontMedium,
  hoverColor: Colors.transparent,
  iconTheme: const IconThemeData(
    color: AppColors.primaryColor,
  ),
  primaryColor: AppColors.primaryColor,
  appBarTheme: const AppBarTheme(
    scrolledUnderElevation: 0,
    titleSpacing: 20,
    iconTheme: IconThemeData(
      color: AppColors.primaryColor,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: AppColors.backgroundColor,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: AppColors.backgroundColor,
    elevation: 0,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: AppColors.iconsColor,
    unselectedItemColor: AppColors.iconsColor,
    selectedLabelStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.iconsColor,
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.iconsColor,
    ),
    selectedIconTheme: IconThemeData(
      size: 32,
    ),
    unselectedIconTheme: IconThemeData(
      size: 32,
    ),
    backgroundColor: AppColors.backgroundColor,
    //backgroundColor: HexColor('333739'),
    elevation: 20,
  ),
  scaffoldBackgroundColor: AppColors.backgroundColor,
);

MaterialColor createMaterialColor(Color color) {
  List<int> strengths = <int>[50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int strength in strengths) {
    final double ds = strength / 900;
    swatch[strength] = Color.fromRGBO(r, g, b, ds);
  }
  return MaterialColor(color.value, swatch);
}
