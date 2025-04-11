import 'package:flutter/material.dart';
import 'package:app_mochila/styles/app_colors.dart';
import 'package:app_mochila/styles/app_text_style.dart';

class CustomInputDescription extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final int maxLines;

  const CustomInputDescription({
    super.key,
    this.hintText,
    this.controller,
    this.maxLines = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backGroundInputColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.only(top: 4), 
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        style: AppTextStyle.normal,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText ?? 'Añade una descripción...',
          hintStyle: AppTextStyle.normalGrey,
          contentPadding: const EdgeInsets.fromLTRB(20, 1, 20, 30), // izquierda, arriba, derecha, abajo
        ),
      ),
    );
  }
}