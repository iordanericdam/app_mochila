import 'package:flutter/material.dart';
import 'package:app_mochila/styles/app_text_style.dart';

class CustomButtonLogin extends StatelessWidget {
  final String text;
  final Gradient gradient;
  final VoidCallback onPressed;
  final double borderRadius;
  final double height;

  const CustomButtonLogin({
    super.key,
    required this.text,
    required this.gradient,
    required this.onPressed,
    this.borderRadius = 15,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5), //OPACIDAD DE LA SOMBRA Y COLOR
            offset: const Offset(0, 4), 
            blurRadius: 4, 
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,  //FONDO TRANSPARENTE PARA VER EL GRADIENTE
          shadowColor: Colors.transparent, // DESHABILITAMOS LA SOMBRA.
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Text(
          text,
          style: AppTextStyle.buttonsWhite,
        ),
      ),
    );
  }
}