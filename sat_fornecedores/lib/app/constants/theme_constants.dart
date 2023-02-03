import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sat_fornecedores/app/shared/utilities.dart';

const primaryColor = Color(0xff016EAF);

ThemeData lightTheme(context) => ThemeData(
      brightness: Brightness.light,
      // primaryColor: Color(0xff016EAF),
      // shadowColor: Color(0x1E000000),
      colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: primaryColor,
          onPrimary: Colors.white,
          secondary: Color(0xFF007DC6),
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          background: Color(0xfffcfcfc),
          onBackground: Color(0xff676767),
          surface: Colors.white,
          onSurface: Color(0xffd9d9d9),
          shadow: Color(0x1E000000),
          onSurfaceVariant: Color(0xff999999)),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(
              vertical: wXD(15, context),
              horizontal: wXD(47, context),
            ),
          ),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xff016EAF),
        centerTitle: true,
        // toolbarHeight: wXD(57, context),
        shadowColor: Color(0x1E000000),
        elevation: 3,
      ),
      buttonTheme: const ButtonThemeData(),
      iconTheme: const IconThemeData(
        opacity: 1,
        color: Colors.white,
        size: 30.0,
      ),
      fontFamily: GoogleFonts.montserrat().fontFamily,
      textTheme: TextTheme(
        bodyMedium: TextStyle(
          color: const Color(0xff555869).withOpacity(.6),
          fontSize: 16,
        ),
        displayLarge: const TextStyle(
          color: Color(0xff707070),
          fontWeight: FontWeight.w500,
          fontSize: 17,
        ),
        displayMedium: const TextStyle(
          color: Color(0xff707070),
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
        titleSmall: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        titleMedium: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 21,
        ),
        titleLarge: const TextStyle(
          color: primaryColor,
          fontWeight: FontWeight.w600,
          fontSize: 25,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        isCollapsed: true,
        hintStyle: TextStyle(
          fontSize: 14,
          color: Color(0xffd9d9d9),
        ),
        border: InputBorder.none,
        isDense: true,
      ),
    );

ThemeData darkTheme(context) => ThemeData(
      brightness: Brightness.light,
    );

// class MyThemes {
//   static final lightTheme = ThemeData(
//     colorScheme: const ColorScheme(
//       brightness: Brightness.light,
//       primary: primaryLight,
//       onPrimary: onPrimaryLight,
//       secondary: secondaryLight,
//       onSecondary: onSecondaryLight,
//       error: errorLight,
//       onError: onErrorLight,
//       background: backgroundLight,
//       onBackground: onBackgroundLight,
//       surface: surfaceLight,
//       onSurface: onSurfaceLight,
//       shadow: Color(0x30000000),
//     ),
//     scaffoldBackgroundColor: backgroundLight,
//     shadowColor: Color(0x30000000),
//   );

//   static final darkTheme = ThemeData(
//     colorScheme: const ColorScheme(
//       brightness: Brightness.dark,
//       primary: primaryDark,
//       onPrimary: onPrimaryDark,
//       secondary: secondaryDark,
//       onSecondary: onSecondaryDark,
//       error: errorDark,
//       onError: onErrorDark,
//       background: backgroundDark,
//       onBackground: onBackgroundDark,
//       surface: surfaceDark,
//       onSurface: onSurfaceDark,
//       shadow: Color(0x30000000),
//     ),
//     scaffoldBackgroundColor: backgroundDark,
//     shadowColor: Color(0x30000000),
//   );
// }

// const primaryLight = Color.fromRGBO(107, 42, 135, 1);
// const onPrimaryLight = Color.fromRGBO(255, 255, 255, 1);
// const secondaryLight = Color.fromRGBO(96, 17, 130, 1);
// const onSecondaryLight = Color.fromRGBO(255, 255, 255, 1);
// const errorLight = Color.fromRGBO(255, 0, 0, 1);
// const onErrorLight = Color.fromRGBO(255, 255, 255, 1);
// const backgroundLight = Color.fromRGBO(244, 244, 244, 1);
// const onBackgroundLight = Color.fromRGBO(59, 59, 59, 1);
// const surfaceLight = Color.fromRGBO(250, 250, 250, 1);
// const onSurfaceLight = Color(0xff707070);
// const shadowLight = Color(0x30000000);

// const primaryDark = Color.fromRGBO(107, 42, 135, 1);
// const onPrimaryDark = Color.fromRGBO(231, 231, 231, 1);
// const secondaryDark = Color.fromRGBO(96, 17, 130, 1);
// const onSecondaryDark = Color.fromRGBO(255, 255, 255, 1);
// const errorDark = Color.fromRGBO(172, 2, 2, 1);
// const onErrorDark = Color.fromARGB(255, 8, 0, 0);
// const backgroundDark = Color.fromRGBO(59, 59, 59, 1);
// const onBackgroundDark = Color.fromRGBO(238, 238, 238, 1);
// const surfaceDark = Color.fromRGBO(64, 64, 64, 1);
// const onSurfaceDark = Color.fromRGBO(228, 228, 228, 1);
// const shadowDark = Color(0x30000000);
