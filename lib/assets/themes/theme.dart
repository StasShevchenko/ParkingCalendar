import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

ThemeData appTheme() => ThemeData(
      textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors.primaryBlue,
          selectionHandleColor: AppColors.primaryAccentRed,
          selectionColor: AppColors.primaryAccentRed),
      focusColor: AppColors.primaryBlue,
      useMaterial3: true,
      visualDensity: const VisualDensity(horizontal: -1, vertical: -1),
      colorScheme: const ColorScheme.highContrastLight(),
      fontFamily: 'Golos',
      appBarTheme: AppBarTheme(
          elevation: 0,
          scrolledUnderElevation: 0.0,
          color: AppColors.primaryBlue,
          titleTextStyle: TextStyle(
            color: AppColors.primaryWhite,
            fontSize: 20,
          )),
      inputDecorationTheme: appInputDecorationTheme(),
      textTheme: appTextTheme(),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: elevatedButtonStyle(),
      ),
    );

InputDecorationTheme appInputDecorationTheme() => InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.secondaryBlue),
        borderRadius: BorderRadius.circular(32)),
    disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32),
        borderSide: BorderSide(color: AppColors.primaryWhite)),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32),
        borderSide: const BorderSide(color: Colors.red)),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32),
        borderSide: const BorderSide(color: Colors.red)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.secondaryBlue),
        borderRadius: BorderRadius.circular(32)),
    labelStyle: TextStyle(color: AppColors.secondaryBlue),
    errorStyle: const TextStyle(color: Colors.red),
    fillColor: AppColors.primaryWhite,
    filled: true);

TextTheme appTextTheme() => TextTheme(
    bodyLarge: TextStyle(
      color: AppColors.secondaryBlue,
      fontSize: 16,
    ),
    bodyMedium: TextStyle(color: AppColors.secondaryBlue),
    titleLarge: TextStyle(color: AppColors.secondaryBlue, fontSize: 28),
    titleMedium: TextStyle(
        color: AppColors.secondaryBlue,
        fontSize: 24,
        fontWeight: FontWeight.w700));

ButtonStyle elevatedButtonStyle() => ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryBlue,
      foregroundColor: AppColors.primaryWhite,
      elevation: 0,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      textStyle:
          const TextStyle(fontFamily: 'Golos', fontWeight: FontWeight.w700),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
    );
