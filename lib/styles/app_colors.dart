//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const backGroundLoginColor1 = Color(0xFF5DB3E3);
  static const backGroundLoginColor2 = Color(0xFF340670);
  static const backgroundLogoColor = Color(0xFF2D2B2B);
  static const strokeInputLoginColor = Color(0xFF8F52DF);
  static const strokeInputRegisterColor = Color(0xFFC1B4D2);
  static const backGroundInputColor = Color(0xFFE3E7EA);
  static const startButtonColor = Color(0xFF3B1978);
  static const checkboxColor = Color(0xFF616161);
  static const recoverButtonColor = Color(0xFF648DDB);

  static const defaultButtonColor = Color(0xFF65558F);

  static const backGroundLoginColor = LinearGradient(colors: [
    Color.fromARGB(255, 76, 42, 120),
    // Color.fromARGB(255, 133, 182, 208),
    backGroundLoginColor1,
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);

  static const inversedBackGroundLoginColor = LinearGradient(colors: [
    backGroundLoginColor1,
    Color.fromARGB(255, 76, 42, 120),
    Color.fromARGB(255, 76, 42, 120),
    backGroundLoginColor1,
    // Color.fromARGB(255, 133, 182, 208),
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);

  static const loginButtonColor = LinearGradient(
    colors: [
      backGroundLoginColor1,
      backGroundLoginColor2,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

//Colors para TeXto

  static const textColor = Color(0xFF000000);
  static const hintTextColor = const Color.fromARGB(255, 103, 101, 101);

//Colores para iconos
  static const iconColor = Color.fromARGB(136, 136, 135, 135);

//Colores para home
}
