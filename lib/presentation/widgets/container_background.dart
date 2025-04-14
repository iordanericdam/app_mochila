import 'package:app_mochila/styles/app_colors.dart';
import 'package:flutter/material.dart';

class ContainerBackground extends StatelessWidget {
  final Widget child;

  const ContainerBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.backGroundInputColor, 
        borderRadius: BorderRadius.circular(50),
      ),
      child: child,
    );
  }
}