import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'my_colors.dart';

class Themes {
  static final lights = ThemeData(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      textTheme: TextTheme(bodyMedium: GoogleFonts.plusJakartaSans(color: const Color(0xff111111))),
      appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          color: Color(0xffffffff),
          toolbarTextStyle: TextStyle(color: Colors.black)),
      useMaterial3: false,
      iconTheme: const IconThemeData(color: Colors.black),
      primarySwatch: Colors.pink,
      scaffoldBackgroundColor: Colors.white,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: Color(0xffffffff))
      // brightness: Brightness.light,
      );

  static final darks = ThemeData(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      textTheme: TextTheme(
        bodyMedium: GoogleFonts.plusJakartaSans(color: const Color(0xffffffff)),
      ),
      appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          color: Color(0xff171725),
          toolbarTextStyle: TextStyle(color: Colors.white)),
      useMaterial3: false,
      iconTheme: const IconThemeData(color: Colors.white),
      primarySwatch: Colors.pink,
      scaffoldBackgroundColor: MyColors.blackBackground,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: Color(0xff171725)));
}
