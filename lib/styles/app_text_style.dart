import 'package:app_mochila/styles/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  static const TextStyle heroTitle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static const TextStyle title = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static const TextStyle normal = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textColor,
  );

  static const TextStyle buttonsWhite = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.backGroundInputColor,
  );

  static const TextStyle normalBold = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static const TextStyle normalBoldWhite = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 255, 255, 255),
  );

  static TextStyle normalGrey = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.hintTextColor,
  );

  static const TextStyle buttonTextNormal = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textColor,
  );
  static const TextStyle buttonTextBold = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );
}
