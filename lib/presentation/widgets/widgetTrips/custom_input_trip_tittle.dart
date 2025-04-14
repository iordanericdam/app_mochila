import 'package:app_mochila/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:app_mochila/styles/app_text_style.dart';
import 'package:app_mochila/styles/app_colors.dart';

class CustomInputTripTitle extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;

  const CustomInputTripTitle({
    super.key,
    this.hintText,
    this.controller,
    this.validator,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backGroundInputColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          insideDefaultBoxShadow(),
        ],
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType ?? TextInputType.text,
        style: AppTextStyle.normal,
        decoration: InputDecoration(
          hintText: hintText ?? '',
          hintStyle: AppTextStyle.normalGrey,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}