import 'package:flutter/material.dart';
import 'package:tm_school/assets/colors.dart';
import 'package:tm_school/assets/fonts.dart';

class AppTheme {
  ThemeData lightTheme() => ThemeData();

  ThemeData darkTheme() {
    final colors = AppColors();
    return ThemeData(
      scaffoldBackgroundColor: colors.scaffoldBackgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: colors.scaffoldBackgroundColor,
      ),
      extensions: [
        AppFonts(
          fontSize13Weight300: TextStyle(
            fontFamily: "Lexend",
            fontSize: 13,
            fontWeight: FontWeight.w300,
            color: colors.black,
          ),
          fontSize32Weight500: TextStyle(
            fontFamily: "Lexend",
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: colors.black,
          ),
          fontSize19Weight400: TextStyle(
            fontFamily: "Lexend",
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: colors.black,
          ),
          fontSize22Weight600: TextStyle(
            fontFamily: "Lexend",
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: colors.black,
          ),
          fontSize22Weight400: TextStyle(
            fontFamily: "Lexend",
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: colors.black,
          ),
          fontSize16Weight400: TextStyle(
            fontFamily: "Lexend",
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: colors.black,
          ),
          fontSize16Weight500: TextStyle(
            fontFamily: "Lexend",
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: colors.black,
          ),
          fontSize16Weight600: TextStyle(
            fontFamily: "Lexend",
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: colors.black,
          ),
          fontSize16Weight700: TextStyle(
            fontFamily: "Lexend",
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: colors.black,
          ),
          fontSize14Weight400: TextStyle(
            fontFamily: "Lexend",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: colors.black,
          ),
          fontSize24Weight700: TextStyle(
            fontFamily: "Lexend",
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: colors.black,
          ),
          fontSize20Weight700: TextStyle(
            fontFamily: "Lexend",
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: colors.black,
          ),
          fontSize20Weight500: TextStyle(
            fontFamily: "Lexend",
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: colors.black,
          ),
          fontSize20Weight400: TextStyle(
            fontFamily: "Lexend",
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: colors.black,
          ),
          fontSize18Weight700: TextStyle(
            fontFamily: "Lexend",
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: colors.black,
          ),
          fontSize18Weight600: TextStyle(
            fontFamily: "Lexend",
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: colors.black,
          ),
          fontSize18Weight500: TextStyle(
            fontFamily: "Lexend",
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: colors.black,
          ),
          fontSize18Weight400: TextStyle(
            fontFamily: "Lexend",
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: colors.black,
          ),
          fontSize15Weight400: TextStyle(
            fontFamily: "Lexend",
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: colors.black,
          ),
          fontSize14Weight700: TextStyle(
            fontFamily: "Lexend",
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: colors.black,
          ),
          fontSize14Weight600: TextStyle(
            fontFamily: "Lexend",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: colors.black,
          ),
          fontSize14Weight500: TextStyle(
            fontFamily: "Lexend",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: colors.black,
          ),
          fontSize12Weight500: TextStyle(
            fontFamily: "Lexend",
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: colors.black,
          ),
          fontSize12Weight400: TextStyle(
            fontFamily: "Lexend",
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: colors.black,
          ),
          fontSize10Weight400: TextStyle(
            fontFamily: "Lexend",
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: colors.black,
          ),
          fontSize8Weight400: TextStyle(
            fontFamily: "Lexend",
            fontSize: 8,
            fontWeight: FontWeight.w400,
            color: colors.black,
          ),
          fontSize30Weight700: TextStyle(
            fontFamily: "Lexend",
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: colors.black,
          ),
          fontSize20Weight600: TextStyle(
            fontFamily: "Lexend",
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: colors.black,
          ),
          fontSize7Weight600: TextStyle(
            fontFamily: "Lexend",
            fontSize: 7,
            fontWeight: FontWeight.w600,
            color: colors.black,
          ),
          fontSize24Weight400: TextStyle(
            fontFamily: "Lexend",
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: colors.black,
          ),
        ),
        
        
//             fontSize13Weight300: TextStyle(
//               fontFamily: "Lexend",
//               fontSize: 13,
//               fontWeight: FontWeight.w300,
//               color: colors.black,
//             ),
//             fontSize32Weight500: TextStyle(
//               fontFamily: "Lexend",
//               fontSize: 22,
//               fontWeight: FontWeight.w400,
//               color: colors.black,
//             ),
//             fontSize19Weight400: TextStyle(
//               fontFamily: "Lexend",
//               fontSize: 22,
//               fontWeight: FontWeight.w400,
//               color: colors.black,
//             ),
//             fontSize22Weight600: TextStyle(
//               fontFamily: "Lexend",
//               fontSize: 22,
//               fontWeight: FontWeight.w400,
//               color: colors.black,
//             ),
//             fontSize22Weight400: TextStyle(
//               fontFamily: "Lexend",
//               fontSize: 22,
//               fontWeight: FontWeight.w400,
//               color: colors.black,
//             ),
//             fontSize16Weight400: TextStyle(
//               fontFamily: "Lexend",
//               fontSize: 16,
//               fontWeight: FontWeight.w400,
//               color: colors.black,
//             ),
//             fontSize16Weight500: TextStyle(
//               fontFamily: "Lexend",
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//               color: colors.black,
//             ),
//             fontSize16Weight600: TextStyle(
//               fontFamily: "Lexend",
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//               color: colors.black,
//             ),
//             fontSize16Weight700: TextStyle(
//               fontFamily: "Lexend",
//               fontSize: 16,
//               fontWeight: FontWeight.w700,
//               color: colors.black,
//             ),
//             fontSize14Weight400: TextStyle(
//               fontFamily: "Lexend",
//               fontSize: 14,
//               fontWeight: FontWeight.w400,
//               color: colors.black,
//             ),
//             fontSize24Weight700: TextStyle(
//               fontFamily: "Lexend",
//               fontSize: 24,
//               fontWeight: FontWeight.w700,
//               color: colors.black,
//             ),
//             fontSize20Weight700: TextStyle(
//               fontFamily: "Lexend",
//               fontSize: 20,
//               fontWeight: FontWeight.w700,
//               color: colors.black,
//             ),
//             fontSize20Weight500: TextStyle(
//               fontFamily: "Lexend",
//               fontSize: 20,
//               fontWeight: FontWeight.w500,
//               color: colors.black,
//             ),
//             fontSize20Weight400: TextStyle(
//               fontFamily: "Lexend",
//               fontSize: 20,
//               fontWeight: FontWeight.w400,
//               color: colors.black,
//             ),
//             fontSize18Weight700: TextStyle(
//               fontFamily: "Lexend",
//               fontSize: 18,
//               fontWeight: FontWeight.w700,
//               color: colors.black,
//             ),
//             fontSize18Weight600: TextStyle(
//               fontFamily: "Lexend",
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//               color: colors.black,
//             ),
//             fontSize18Weight500: TextStyle(
//               fontFamily: "Lexend",
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//               color: colors.black,
//             ),
//             fontSize18Weight400: TextStyle(
//               fontFamily: "Lexend",
//               fontSize: 18,
//               fontWeight: FontWeight.w400,
//               color: colors.black,
//             ),
//             fontSize15Weight400: TextStyle(
//               fontFamily: "Lexend",
//               fontSize: 15,
//               fontWeight: FontWeight.w400,
//               color: colors.black,
//             ),
//             fontSize14Weight700: TextStyle(
//               fontFamily: "Lexend",
//               fontSize: 14,
//               fontWeight: FontWeight.w700,
//               color: colors.black,
//             ),
//             fontSize14Weight600: TextStyle(
//               fontFamily: "Lexend",
//               fontSize: 14,
//               fontWeight: FontWeight.w600,
//               color: colors.black,
//             ),
//             fontSize14Weight500: TextStyle(
//               fontFamily: "Lexend",
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//               color: colors.black,
//             ),
//             fontSize12Weight500: TextStyle(
//               fontFamily: "Lexend",
//               fontSize: 12,
//               fontWeight: FontWeight.w500,
//               color: colors.black,
//             ),
//             fontSize12Weight400: TextStyle(
//               fontFamily: "Lexend",
//               fontSize: 12,
//               fontWeight: FontWeight.w400,
//               color: colors.black,
//             ),
//             fontSize10Weight400: TextStyle(
//               fontFamily: "Lexend",
//               fontSize: 10,
//               fontWeight: FontWeight.w400,
//               color: colors.black,
//             ),
//             fontSize8Weight400: TextStyle(
//               fontFamily: "Lexend",
//               fontSize: 8,
//               fontWeight: FontWeight.w400,
//               color: colors.black,
//             ),
//             fontSize30Weight700: TextStyle(
//               fontFamily: "Lexend",
//               fontSize: 30,
//               fontWeight: FontWeight.w700,
//               color: colors.black,
//             ),
//             fontSize20Weight600: TextStyle(
//               fontFamily: "Lexend",
//               fontSize: 20,
//               fontWeight: FontWeight.w600,
//               color: colors.black,
//             ),
//             fontSize7Weight600: TextStyle(
//               fontFamily: "Lexend",
//               fontSize: 7,
//               fontWeight: FontWeight.w600,
//               color: colors.black,
//             )),
          
         
      ],
    );
  }
}
