// ================= App Themes =================
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:balance_me/localization/locale_controller.dart';
import 'package:balance_me/localization/languages_controller.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:balance_me/pages/home.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/config.dart' as config;
import 'package:balance_me/global/constants.dart' as gc;

class Themes{
  const Themes({this.isDark = false});
  final bool isDark;

  ThemeData _darkMode(){
    return ThemeData(
      primaryColor: gc.darkPrimaryColor,
      primaryColorLight: gc.darkPrimaryLightColor,
      primaryColorDark: gc.darkPrimaryDarkColor,
      canvasColor: gc.darkPrimaryDarkColor,
      toggleableActiveColor: gc.darkSecondaryColor,
      unselectedWidgetColor: gc.darkSecondaryColor,
      scaffoldBackgroundColor: gc.darkPrimaryColor,
      highlightColor: gc.darkSecondaryColor,
      hoverColor: gc.darkVeryLightColor,
      backgroundColor: gc.darkPrimaryLightColor,
      focusColor: gc.darkVeryLightColor,
      cardColor: gc.darkPrimaryLightColor,
      shadowColor: gc.darkPrimaryDarkColor,
      dividerColor: gc.darkPrimaryColor,
      disabledColor: gc.disabledColor,
      indicatorColor: gc.darkSecondaryColor,
      hintColor: gc.whiteColor,
      bottomAppBarColor: gc.darkSecondaryColor,
      splashColor: gc.whiteColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: gc.darkPrimaryColor,
        foregroundColor: gc.darkSecondaryColor,
        titleTextStyle: TextStyle(color: gc.darkSecondaryColor, fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: gc.darkSecondaryColor,
        foregroundColor: Colors.black,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: gc.darkPrimaryDarkColor,
          selectedItemColor: gc.darkSecondaryColor,
          unselectedItemColor: gc.darkPrimaryLightColor
      ),
      iconTheme: IconThemeData(
        color: gc.darkVeryLightColor,
        size: gc.iconSize,
      ),
      textTheme: const TextTheme(
        headline1: TextStyle(color: gc.darkPrimaryDarkColor, fontSize: 20.0, fontWeight: FontWeight.bold),
        headline2: TextStyle(color: gc.darkPrimaryDarkColor, fontSize: 20.0),
        headline3: TextStyle(color: gc.darkPrimaryDarkColor, fontSize: 18.0, fontWeight: FontWeight.bold),
        headline4: TextStyle(color: gc.darkPrimaryDarkColor, fontSize: 18.0),
        headline5: TextStyle(color: gc.darkPrimaryDarkColor, fontSize: 15.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(color: gc.darkPrimaryDarkColor, fontSize: 15.0),
        bodyText1: TextStyle(color: gc.darkPrimaryColor, fontSize: 15.0),
        bodyText2: TextStyle(color: gc.whiteColor, fontSize: 15.0),
        subtitle1: TextStyle(color: gc.whiteColor, fontSize: 15.0, fontWeight: FontWeight.bold),
        subtitle2: TextStyle(color: gc.darkSecondaryColor, fontSize: 15, fontWeight: FontWeight.bold),
        caption: TextStyle(color: gc.darkSecondaryColor, fontSize: 15, fontWeight: FontWeight.bold),
        overline: TextStyle(color: gc.darkPrimaryDarkColor, fontSize: 15.0),
        button: TextStyle(color: gc.whiteColor, fontSize: 15.0, fontWeight: FontWeight.bold),
      ),
      dialogTheme: DialogTheme(
          backgroundColor: gc.darkPrimaryLightColor,
          titleTextStyle: TextStyle(color: gc.whiteColor, fontSize: 15.0, fontWeight: FontWeight.bold),
          contentTextStyle: TextStyle(color: gc.whiteColor, fontSize: 15.0),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(gc.textFieldRadius),
          borderSide: const BorderSide(
            color: gc.darkSecondaryColor,
            width: gc.borderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(gc.textFieldRadius),
          borderSide: const BorderSide(
            color: gc.darkSecondaryColor,
            width: gc.borderWidth,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(gc.textFieldRadius),
          borderSide: const BorderSide(
            color: gc.darkSecondaryColor,
            width: gc.borderWidth,
          ),
        ),
        labelStyle: TextStyle(color: gc.whiteColor, fontSize: 15.0),
        hintStyle: TextStyle(color: gc.whiteColor, fontSize: 15.0),
      ),
      dividerTheme: DividerThemeData(
        color: gc.darkPrimaryDarkColor,
        thickness: gc.dividerThickness,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(gc.darkSecondaryColor),
            foregroundColor: MaterialStateProperty.all<Color>(gc.darkPrimaryDarkColor),
            shadowColor: MaterialStateProperty.all<Color>(gc.darkPrimaryDarkColor),
          ),
      ),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(gc.darkSecondaryDarkColor)
          )
      ),
      cardTheme: CardTheme(
        color: gc.darkPrimaryLightColor,
        shadowColor: gc.darkPrimaryDarkColor,
        elevation: gc.cardElevationHeight,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: gc.darkSecondaryLightColor,
          ),
          borderRadius: BorderRadius.circular(gc.cardBorderRadius),
        ),
      ),
      tabBarTheme: TabBarTheme(
          indicator: BoxDecoration(
            color: gc.darkSecondaryDarkColor,
            borderRadius: BorderRadius.circular(gc.tabBorderRadius),
            boxShadow: [BoxShadow(color: Colors.black, blurRadius: 15, offset: Offset(5,2))]
          ),
      ),
    );
  }

  ThemeData _brightMode(){
    return ThemeData(
      primaryColor: gc.primaryColor,
      primaryColorLight: gc.primaryLightColor,
      primaryColorDark: gc.primaryDarkColor,
      canvasColor: gc.primaryDarkColor,
      toggleableActiveColor: gc.primaryColor,
      unselectedWidgetColor: gc.primaryColor,
      scaffoldBackgroundColor: gc.secondaryColor,
      highlightColor: gc.secondaryDarkColor,
      hoverColor: gc.primaryColor,
      backgroundColor: gc.pieCharDefaultCategoryColor,
      focusColor: gc.backgroundDesignColor,
      cardColor: gc.secondaryColor,
      shadowColor: gc.primaryDarkColor,
      dividerColor: gc.primaryColor,
      disabledColor: gc.disabledColor,
      indicatorColor: gc.secondaryColor,
      hintColor: gc.whiteColor,
      bottomAppBarColor: gc.tabBarColor,
      splashColor: gc.darkPrimaryDarkColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: gc.primaryColor,
        foregroundColor: gc.secondaryColor,
        titleTextStyle: TextStyle(color: gc.secondaryColor, fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: gc.primaryColor,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: gc.secondaryColor,
          selectedItemColor: gc.primaryColor,
          unselectedItemColor: gc.secondaryDarkColor
      ),
      iconTheme: IconThemeData(
        color: gc.primaryDarkColor,
        size: gc.iconSize,
      ),
      textTheme: const TextTheme(
        headline1: TextStyle(color: gc.secondaryColor, fontSize: 20.0, fontWeight: FontWeight.bold),
        headline2: TextStyle(color: gc.secondaryColor, fontSize: 20.0),
        headline3: TextStyle(color: gc.secondaryColor, fontSize: 18.0, fontWeight: FontWeight.bold),
        headline4: TextStyle(color: gc.secondaryColor, fontSize: 18.0),
        headline5: TextStyle(color: gc.secondaryColor, fontSize: 15.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(color: gc.secondaryColor, fontSize: 15.0),
        bodyText1: TextStyle(color: gc.primaryColor, fontSize: 15.0),
        bodyText2: TextStyle(color: gc.blackColor, fontSize: 15.0),
        subtitle1: TextStyle(color: gc.primaryDarkColor, fontSize: 15.0, fontWeight: FontWeight.bold),
        subtitle2: TextStyle(color: gc.secondaryColor, fontSize: 15, fontWeight: FontWeight.bold),
        caption: TextStyle(color: gc.primaryColor, fontSize: 15, fontWeight: FontWeight.bold),
        overline: TextStyle(color: gc.primaryDarkColor, fontSize: 15.0),
        button: TextStyle(color: gc.blackColor, fontSize: 15.0, fontWeight: FontWeight.bold),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: gc.secondaryColor,
        titleTextStyle: TextStyle(color: gc.blackColor, fontSize: 15.0, fontWeight: FontWeight.bold),
        contentTextStyle: TextStyle(color: gc.blackColor, fontSize: 15.0),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(gc.textFieldRadius),
          borderSide: const BorderSide(
            color: gc.primaryColor,
            width: gc.borderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(gc.textFieldRadius),
          borderSide: const BorderSide(
            color: gc.primaryColor,
            width: gc.borderWidth,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(gc.textFieldRadius),
          borderSide: const BorderSide(
            color: gc.primaryColor,
            width: gc.borderWidth,
          ),
        ),
        labelStyle: TextStyle(color: gc.blackColor, fontSize: 15.0),
        hintStyle: TextStyle(color: gc.blackColor, fontSize: 15.0),
        prefixStyle: TextStyle(color: gc.blackColor, fontSize: 15.0),
        suffixStyle: TextStyle(color: gc.blackColor, fontSize: 15.0),
      ),
      dividerTheme: DividerThemeData(
        color: gc.primaryDarkColor,
        thickness: gc.dividerThickness,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(gc.primaryColor),
          foregroundColor: MaterialStateProperty.all<Color>(gc.secondaryColor),
          shadowColor: MaterialStateProperty.all<Color>(gc.primaryDarkColor),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(gc.primaryColor)
          )
      ),
      cardTheme: CardTheme(
        color: gc.secondaryColor,
        shadowColor: gc.shadowColor,
        elevation: gc.cardElevationHeight,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: gc.primaryColor,
          ),
          borderRadius: BorderRadius.circular(gc.cardBorderRadius),
        ),
      ),
      tabBarTheme: TabBarTheme(
        indicator: BoxDecoration(
            color: gc.tabIndicatorColor,
            borderRadius: BorderRadius.circular(gc.tabBorderRadius),
            boxShadow: [BoxShadow(color: Colors.black, blurRadius: 15, offset: Offset(5,2))]
        ),
      ),
    );
  }

  ThemeData getTheme(){
    return isDark ? _darkMode() :_brightMode();
  }
}