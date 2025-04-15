import 'package:flutter/material.dart';
import 'package:app_mochila/styles/app_colors.dart';
import 'package:app_mochila/styles/app_text_style.dart';

class FloatingButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double borderRadius;
  final double height;

  const FloatingButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.borderRadius = 40,
    this.height = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: AppColors.loginButtonColor, // AQUÍ USAMOS EL GRADIENTE
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.5),
            offset: const Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
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