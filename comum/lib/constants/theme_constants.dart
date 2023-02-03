// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const primaryColorLight = Color(0xff016EAF);
const primaryVariantColorLight = Color(0xff1363DF);
const secondaryColorLight = Color(0xff47b5ff);
const secondaryVariantColorLight = Color(0xffDFF6FF);
const tertiaryColorLight = Color(0xff06283D);

const backgroundColorLight = Color(0xfffcfcfc);
const onBackgroundLight = Color(0xff4B4B4B);
const onSurfaceLight = Color(0xff848484);

const primaryContainerColorLight = Color(0xffd9d9d9);
const onPrimaryContainerColorLight = Color(0xffD3D3D3);
const onSurfaceVariantColorLight = Color(0xffEFEFEF);
const secondaryContainerColorLight = Color(0xff676767);

const shadowColorLight = Color.fromRGBO(0, 0, 0, 0.16);

ThemeData lightTheme(context) => ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme(
        primary: primaryColorLight,
        primaryVariant: primaryVariantColorLight,
        onPrimary: Colors.white,
        secondary: secondaryColorLight,
        secondaryVariant: secondaryVariantColorLight,
        onSecondary: Colors.white,
        tertiary: tertiaryColorLight,
        brightness: Brightness.light,
        error: Colors.red,
        onError: Colors.white,
        background: backgroundColorLight,
        onBackground: onBackgroundLight,
        surfaceVariant: const Color(0x00EEEEEE),
        outline: onBackgroundLight.withOpacity(.6),
        surface: Colors.white,
        onSurface: onSurfaceLight,
        shadow: shadowColorLight,
        onSurfaceVariant: onSurfaceVariantColorLight,
        primaryContainer: primaryContainerColorLight,
        onPrimaryContainer: onPrimaryContainerColorLight,
        secondaryContainer: secondaryContainerColorLight,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 47,
            ),
          ),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xff016EAF),
        centerTitle: true,
        // toolbarHeight: 57,
        shadowColor: Color(0x1E000000),
        elevation: 3,
      ),
      buttonTheme: const ButtonThemeData(),
      iconTheme: const IconThemeData(
        opacity: 1,
        color: Colors.white,
        size: 30.0,
      ),
      fontFamily: GoogleFonts.roboto().fontFamily,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          color: primaryColorLight,
          fontSize: 16,
        ),
        bodyLarge: TextStyle(
          color: primaryColorLight,
          fontSize: 18,
        ),
        bodySmall: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
        displaySmall: TextStyle(
          color: onSurfaceLight,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        displayMedium: TextStyle(
          color: onSurfaceLight,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        displayLarge: TextStyle(
          color: onBackgroundLight,
          fontWeight: FontWeight.w500,
          fontSize: 17,
        ),
        labelLarge: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        labelMedium: TextStyle(
          color: primaryColorLight,
          fontWeight: FontWeight.w500,
          fontSize: 17,
        ),
        titleSmall: TextStyle(
          color: primaryColorLight,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        titleMedium: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 22,
        ),
        titleLarge: TextStyle(
          color: primaryColorLight,
          fontWeight: FontWeight.w500,
          fontSize: 23,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        isCollapsed: true,
        hintStyle: TextStyle(
          fontSize: 14,
          color: primaryContainerColorLight,
        ),
        border: InputBorder.none,
        isDense: true,
      ),
    );

const primaryColorDark = Color.fromARGB(255, 0, 131, 207);
const onPrimaryColorDark = Color(0xFFFFFFFF);
const primaryVariantColorDark = Color(0xFF00314E);
const secondaryColorDark = Color.fromARGB(255, 7, 124, 202);
const secondaryVariantColorDark = Color.fromARGB(255, 0, 41, 58);
const tertiaryColorDark = Color(0xff06283D);

const backgroundColorDark = Color.fromARGB(255, 32, 32, 32);
const onBackgroundDark = Color.fromARGB(255, 219, 219, 219);
const surfaceColorDark = Color.fromARGB(255, 48, 48, 48);
const onSurfaceDark = Color.fromARGB(255, 187, 187, 187);

const primaryContainerColorDark = Color.fromARGB(255, 73, 73, 73);
const onPrimaryContainerColorDark = Color.fromARGB(255, 134, 134, 134);
const onSurfaceVariantColorDark = Color.fromARGB(255, 56, 56, 56);
const secondaryContainerColorDark = Color(0xFFA3A3A3);

const shadowColorDark = Color(0x28FFFFFF);

ThemeData darkTheme(context) => ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme(
        primary: primaryColorDark,
        primaryVariant: primaryVariantColorDark,
        onPrimary: onPrimaryColorDark,
        secondary: secondaryColorDark,
        secondaryVariant: secondaryVariantColorDark,
        onSecondary: Colors.white,
        tertiary: tertiaryColorDark,
        brightness: Brightness.dark,
        error: Colors.red,
        onError: Colors.white,
        background: backgroundColorDark,
        onBackground: onBackgroundDark,
        surfaceVariant: const Color(0x00EEEEEE),
        outline: onBackgroundDark.withOpacity(.6),
        surface: surfaceColorDark,
        onSurface: onSurfaceDark,
        shadow: shadowColorDark,
        onSurfaceVariant: onSurfaceVariantColorDark,
        primaryContainer: primaryContainerColorDark,
        onPrimaryContainer: onPrimaryContainerColorDark,
        secondaryContainer: secondaryContainerColorDark,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 47,
            ),
          ),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xff016EAF),
        centerTitle: true,
        // toolbarHeight: 57,
        shadowColor: Color(0x1E000000),
        elevation: 3,
      ),
      buttonTheme: const ButtonThemeData(),
      iconTheme: const IconThemeData(
        opacity: 1,
        color: Colors.white,
        size: 30.0,
      ),
      fontFamily: GoogleFonts.roboto().fontFamily,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          color: primaryColorDark,
          fontSize: 16,
        ),
        bodyLarge: TextStyle(
          color: primaryColorDark,
          fontSize: 18,
        ),
        bodySmall: TextStyle(
          color: onBackgroundDark,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
        displaySmall: TextStyle(
          color: onSurfaceDark,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        displayMedium: TextStyle(
          color: onSurfaceDark,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        displayLarge: TextStyle(
          color: onBackgroundDark,
          fontWeight: FontWeight.w500,
          fontSize: 17,
        ),
        labelLarge: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        labelMedium: TextStyle(
          color: onSurfaceDark,
          fontWeight: FontWeight.w500,
          fontSize: 17,
        ),
        titleSmall: TextStyle(
          color: primaryColorDark,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        titleMedium: TextStyle(
          color: onPrimaryColorDark,
          fontWeight: FontWeight.w500,
          fontSize: 22,
        ),
        titleLarge: TextStyle(
          color: primaryColorDark,
          fontWeight: FontWeight.w500,
          fontSize: 23,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        isCollapsed: true,
        hintStyle: TextStyle(
          fontSize: 14,
          color: primaryContainerColorDark,
        ),
        border: InputBorder.none,
        isDense: true,
      ),
    );
