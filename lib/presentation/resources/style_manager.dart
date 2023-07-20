import 'package:flutter/material.dart';
import 'package:inside_1/presentation/resources/color_manager.dart';
import 'package:inside_1/presentation/resources/font_manager.dart';

TextStyle _getMaterialTextStyle(
    double fontSize, double lineHeight, double tracking, FontWeight fontWeight,
    {String? fontFamily, Color? color}) {
  return TextStyle(
    color: color ?? ColorManager.textColor,
    fontFamily: fontFamily ?? FontConstant.fontFamily2,
    fontWeight: fontWeight,
    fontSize: fontSize,
    height: lineHeight,
    letterSpacing: tracking,
  );
}

TextStyle get displayLarge =>
    _getMaterialTextStyle(FontSize.s57, 1.1, -0.25, FontWeightManager.medium);
TextStyle get displayMedium =>
    _getMaterialTextStyle(FontSize.s36, 1.1, 0, FontWeightManager.semiBold,
        fontFamily: FontConstant.fontFamily, color: ColorManager.secondary);
TextStyle get displaySmall =>
    _getMaterialTextStyle(FontSize.s32, 1.1, 0, FontWeightManager.medium,
        fontFamily: FontConstant.fontFamily, color: ColorManager.gray11);

TextStyle get headlineLarge =>
    _getMaterialTextStyle(FontSize.s24, 1.1, 0, FontWeightManager.bold,
        fontFamily: FontConstant.fontFamily); //h1 done
TextStyle get headlineMedium =>
    _getMaterialTextStyle(FontSize.s20, 1.1, 0, FontWeightManager.semiBold,
        fontFamily: FontConstant.fontFamily); // h2 done
TextStyle get headlineSmall =>
    _getMaterialTextStyle(FontSize.s18, 1.1, 0, FontWeightManager.regular,
        fontFamily: FontConstant.fontFamily); //h3 done

TextStyle get titleLarge => _getMaterialTextStyle(
    FontSize.s16, 1.5, 0, FontWeightManager.semiBold); // done
TextStyle get titleMedium =>
    _getMaterialTextStyle(FontSize.s16, 1.25, 0.1, FontWeightManager.semiBold);
TextStyle get titleSmall =>
    _getMaterialTextStyle(FontSize.s14, 1.5, 0.1, FontWeightManager.regular);

TextStyle get labelLarge => _getMaterialTextStyle(
    FontSize.s14, 1.25, 0.1, FontWeightManager.semiBold); // For Buttons done
TextStyle get labelMedium => _getMaterialTextStyle(
    FontSize.s14, 1.5, 0.4, FontWeightManager.regular); // nav bar done
TextStyle get labelSmall =>
    _getMaterialTextStyle(FontSize.s11, 1.3, 0.4, FontWeightManager.semiBold);

TextStyle get bodyLarge => _getMaterialTextStyle(FontSize.s16, 1.5, 0.5,
    FontWeightManager.regular); // input text for text field done
TextStyle get bodyMedium => _getMaterialTextStyle(
    FontSize.s14, 1.5, 0.35, FontWeightManager.regular); // done
TextStyle get bodySmall =>
    _getMaterialTextStyle(FontSize.s12, 1.3, 0.4, FontWeightManager.semiBold);
