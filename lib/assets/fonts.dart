import 'package:flutter/material.dart';

class AppFonts extends ThemeExtension<AppFonts> {
  final TextStyle fontSize32Weight500;

  final TextStyle fontSize30Weight700;

  final TextStyle fontSize24Weight700;

  final TextStyle fontSize22Weight600;
  final TextStyle fontSize22Weight400;

  final TextStyle fontSize20Weight700;
  final TextStyle fontSize20Weight600;
  final TextStyle fontSize20Weight500;
  final TextStyle fontSize20Weight400;

  final TextStyle fontSize19Weight400;

  final TextStyle fontSize18Weight700;
  final TextStyle fontSize18Weight600;
  final TextStyle fontSize18Weight500;
  final TextStyle fontSize18Weight400;

  final TextStyle fontSize16Weight700;
  final TextStyle fontSize16Weight600;
  final TextStyle fontSize16Weight500;
  final TextStyle fontSize16Weight400;

  final TextStyle fontSize15Weight400;

  final TextStyle fontSize14Weight700;
  final TextStyle fontSize14Weight600;
  final TextStyle fontSize14Weight500;

  final TextStyle fontSize14Weight400;

  final TextStyle fontSize13Weight300;

  final TextStyle fontSize12Weight500;
  final TextStyle fontSize12Weight400;
  final TextStyle fontSize10Weight400;
  final TextStyle fontSize8Weight400;
  final TextStyle fontSize7Weight600;
  final TextStyle fontSize24Weight400;

  AppFonts( {
    required this.fontSize13Weight300,
    required this.fontSize32Weight500,
    required this.fontSize22Weight600,
    required this.fontSize22Weight400,
    required this.fontSize19Weight400,
    required this.fontSize30Weight700,
    required this.fontSize24Weight700,
    required this.fontSize20Weight700,
    required this.fontSize20Weight500,
    required this.fontSize20Weight400,
    required this.fontSize18Weight700,
    required this.fontSize18Weight600,
    required this.fontSize18Weight500,
    required this.fontSize18Weight400,
    required this.fontSize16Weight700,
    required this.fontSize16Weight600,
    required this.fontSize16Weight500,
    required this.fontSize16Weight400,
    required this.fontSize15Weight400,
    required this.fontSize14Weight700,
    required this.fontSize14Weight600,
    required this.fontSize14Weight500,
    required this.fontSize14Weight400,
    required this.fontSize12Weight500,
    required this.fontSize12Weight400,
    required this.fontSize10Weight400,
    required this.fontSize8Weight400,
    required this.fontSize20Weight600,
    required this.fontSize7Weight600,
    required this.fontSize24Weight400,
  });

  @override
  ThemeExtension<AppFonts> copyWith() {
    throw UnimplementedError();
  }

  @override
  ThemeExtension<AppFonts> lerp(
      covariant ThemeExtension<AppFonts>? other, double t) {
    if (other is! AppFonts) {
      return this;
    }
    return AppFonts(
        fontSize13Weight300: fontSize13Weight300,
        fontSize32Weight500: fontSize32Weight500,
        fontSize22Weight600: fontSize22Weight600,
        fontSize22Weight400: fontSize22Weight400,
        fontSize19Weight400: fontSize19Weight400,
        fontSize30Weight700: fontSize30Weight700,
        fontSize24Weight700: fontSize24Weight700,
        fontSize20Weight700: fontSize20Weight700,
        fontSize20Weight500: fontSize20Weight500,
        fontSize20Weight400: fontSize20Weight400,
        fontSize18Weight700: fontSize18Weight700,
        fontSize18Weight600: fontSize18Weight600,
        fontSize18Weight500: fontSize18Weight500,
        fontSize18Weight400: fontSize18Weight400,
        fontSize16Weight700: fontSize16Weight700,
        fontSize16Weight600: fontSize16Weight600,
        fontSize16Weight500: fontSize16Weight500,
        fontSize16Weight400: fontSize16Weight400,
        fontSize15Weight400: fontSize15Weight400,
        fontSize14Weight700: fontSize14Weight700,
        fontSize14Weight600: fontSize14Weight600,
        fontSize14Weight500: fontSize14Weight500,
        fontSize14Weight400: fontSize14Weight400,
        fontSize12Weight500: fontSize12Weight500,
        fontSize12Weight400: fontSize12Weight400,
        fontSize10Weight400: fontSize10Weight400,
        fontSize8Weight400: fontSize8Weight400,
        fontSize20Weight600: fontSize20Weight600,
        fontSize7Weight600: fontSize7Weight600,
        fontSize24Weight400: fontSize24Weight400);
  }
}
