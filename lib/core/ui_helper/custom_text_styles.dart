import 'package:flutter/material.dart';
import 'package:scoped_model_demo/core/constants/app_colors.dart';
import 'package:scoped_model_demo/core/ui_helper/shared_component/theme_helper.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  static get white10 => theme.textTheme.bodyMedium!.copyWith(
        color: Colors.white,
        fontSize: 10,
      );

  static get white11 => theme.textTheme.bodyMedium!.copyWith(
        color: Colors.white,
        fontSize: 11,
      );

  static get white12 => theme.textTheme.bodyMedium!.copyWith(
        color: Colors.white,
        fontSize: 12,
      );

  static get white13 => theme.textTheme.bodyMedium!.copyWith(
        color: Colors.white,
        fontSize: 13,
      );

  static get white14 => theme.textTheme.bodyMedium!.copyWith(
        color: Colors.white,
        fontSize: 14,
      );

  static get white15 => theme.textTheme.bodyMedium!.copyWith(
        color: Colors.white,
        fontSize: 15,
      );

  static get white16 => theme.textTheme.bodyMedium!.copyWith(
        color: Colors.white,
        fontSize: 15,
      );

  static get white17 => theme.textTheme.bodyMedium!.copyWith(
        color: Colors.white,
        fontSize: 17,
      );

  static get white18 => theme.textTheme.bodyMedium!.copyWith(
        color: Colors.white,
        fontSize: 18,
      );

  static get white19 => theme.textTheme.bodyMedium!.copyWith(
        color: Colors.white,
        fontSize: 19,
      );

  static get white20 => theme.textTheme.bodyMedium!.copyWith(
        color: Colors.white,
        fontSize: 20,
      );

  static get white14Bold => theme.textTheme.bodyMedium!.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      );

  static get black10 => theme.textTheme.bodyMedium!.copyWith(
        color: Colors.black,
        fontSize: 10,
      );

  static get black11 => theme.textTheme.bodyMedium!.copyWith(
        color: Colors.black,
        fontSize: 11,
      );

  static get black12 => theme.textTheme.bodyMedium!.copyWith(
        color: Colors.black,
        fontSize: 12,
      );

  static get black13 => theme.textTheme.bodyMedium!.copyWith(
        color: Colors.black,
        fontSize: 13,
      );

  static get black14 => theme.textTheme.bodyMedium!.copyWith(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      );

  static get black15 => theme.textTheme.bodyMedium!.copyWith(
        color: Colors.black,
        fontSize: 15,
      );

  static get black16 => theme.textTheme.bodyMedium!.copyWith(
        color: Colors.black,
        fontSize: 15,
      );

  static get blackBold14 => theme.textTheme.bodyMedium!.copyWith(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 14,
      );

  static get blackBold16 => theme.textTheme.bodyMedium!.copyWith(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 15,
      );

  static get black17 => theme.textTheme.bodyMedium!.copyWith(
        color: Colors.black,
        fontSize: 17,
      );

  static get black18 => theme.textTheme.bodyMedium!.copyWith(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      );

  static get blackBold18 => theme.textTheme.bodyMedium!.copyWith(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      );

  static get black19 => theme.textTheme.bodyMedium!.copyWith(
        color: Colors.black,
        fontSize: 19,
      );

  static get black20 => theme.textTheme.bodyMedium!.copyWith(
        color: Colors.black,
        fontSize: 20,
      );

  static get blackBold19 => theme.textTheme.bodyMedium!.copyWith(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 19,
      );

  static get blackBold21 => theme.textTheme.bodyMedium!.copyWith(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 21,
      );

  static get black32 => theme.textTheme.bodyMedium!.copyWith(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 32,
      );

  static get blackBold32 => theme.textTheme.bodyMedium!.copyWith(
        color: Colors.black,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      );

  static get gray14 => theme.textTheme.bodyMedium!.copyWith(
        color: Colors.grey,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      );

  static get gray12 => theme.textTheme.bodyMedium!.copyWith(
        color: Colors.grey,
        fontWeight: FontWeight.w400,
        fontSize: 12,
      );

  static get gray16 => theme.textTheme.bodyMedium!.copyWith(
        color: Colors.grey,
        fontSize: 16,
      );

  static get semiBlack12 => theme.textTheme.bodyMedium!.copyWith(
        color: AppColors.semiBlack,
        fontSize: 12,
      );
}

extension on TextStyle {
  TextStyle get dINNextLTArabic {
    return copyWith(
      fontFamily: 'DIN Next LT Arabic',
    );
  }
}
