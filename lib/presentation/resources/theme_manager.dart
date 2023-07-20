import 'package:flutter/material.dart';
import 'package:inside_1/presentation/resources/color_manager.dart';
import 'package:inside_1/presentation/resources/style_manager.dart';
import 'package:inside_1/presentation/resources/value_manager.dart';

getApplicationTheme () {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: ColorManager.secondary,
      background: ColorManager.backgroundColor,
      surface: ColorManager.backgroundColor,
      onBackground: ColorManager.textColor,
      outline: ColorManager.backgroundColor,
    ),
    textTheme: TextTheme(
      displayLarge: displayLarge,
      displayMedium: displayMedium,
      displaySmall: displaySmall,
      headlineLarge: headlineLarge,
      headlineMedium: headlineMedium,
      headlineSmall: headlineSmall,
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      titleSmall: titleSmall,
      labelLarge: labelLarge,
      labelMedium: labelMedium,
      labelSmall: labelSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
    ),
    appBarTheme: AppBarTheme(
      titleTextStyle: titleSmall.copyWith(color: ColorManager.secondaryTextColor),
      color: ColorManager.backgroundColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.secondary,
        foregroundColor: ColorManager.backgroundColor,
        minimumSize: const Size(double.maxFinite, AppSize.s50),
        padding: const EdgeInsets.symmetric(vertical: AppPadding.p16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.r10),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ColorManager.secondary,
        backgroundColor: ColorManager.backgroundColor,
        minimumSize: const Size(double.maxFinite, AppSize.s40),
        padding: const EdgeInsets.symmetric(vertical: AppPadding.p16),
        side: BorderSide(
          color: ColorManager.secondary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.r10),
        ),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: ColorManager.secondary,
      indicatorColor: Colors.transparent,
      labelTextStyle: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return labelLarge.copyWith(height: 1, color: ColorManager.backgroundColor);
        } else {
          return labelMedium.copyWith(height: 1, color: ColorManager.white);
        }
      }),
      // backgroundColor: ColorManager.navBarBackgroundColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: ColorManager.gray6),
      contentPadding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16, vertical: AppPadding.p13),
      fillColor: ColorManager.white,
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.r10),
      ),
    ),
  );
}