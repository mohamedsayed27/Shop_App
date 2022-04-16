import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightTheme = ThemeData(

  scaffoldBackgroundColor: Colors.white,
  primarySwatch: Colors.deepPurple,
  floatingActionButtonTheme:  const FloatingActionButtonThemeData(
      backgroundColor: Colors.deepPurple
  ),
  appBarTheme:    const AppBarTheme(
      titleSpacing: 20,
      iconTheme: IconThemeData(
          color: Colors.black
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.bold
      ),
      backgroundColor: Colors.white,
      elevation: 0.0
  ),
  bottomNavigationBarTheme:    const BottomNavigationBarThemeData(
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepPurple,
    backgroundColor:  Colors.white,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 30
    ),
  ),

);
ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor:HexColor('333739'),
  primarySwatch: Colors.deepPurple,
  appBarTheme:   AppBarTheme(
      titleSpacing: 20,
      iconTheme:   const IconThemeData(
          color: Colors.white
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor:HexColor('333739') ,
        statusBarIconBrightness: Brightness.light,
      ),
      titleTextStyle:  const TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold
      ),
      backgroundColor: HexColor('333739'),
      elevation: 0.0
  ),
  bottomNavigationBarTheme:  BottomNavigationBarThemeData(
    unselectedItemColor: Colors.white,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepPurple,
    backgroundColor:  HexColor('333739'),
  ),
  textTheme:  const TextTheme(
    bodyText1: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),

);