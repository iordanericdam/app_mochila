import 'package:app_mochila/styles/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final VoidCallback onPressed;

  // Constructor
  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          // padding: const EdgeInsets.symmetric(
          //     horizontal: 30, vertical: 15),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: AppTextStyle.buttonsWhite,
        ),
      ),
    );
  }
}
