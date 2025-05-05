import 'package:flutter/material.dart';
import 'package:app_mochila/styles/app_text_style.dart';
import 'package:app_mochila/styles/app_colors.dart';
import 'package:app_mochila/styles/constants.dart';

class CustomInputTripTitle extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;

  const CustomInputTripTitle({
    super.key,
    this.hintText,
    this.controller,
    this.validator,
    this.keyboardType,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: validator,
      builder: (fieldState) { //fieldState contiene el estado actual del campo
        final errorText = fieldState.errorText;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.backGroundInputColor,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [insideDefaultBoxShadow()],
                border: errorText != null
                    ? Border.all(color: Colors.red, width: 1.5)
                    : null,
              ),
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                keyboardType: keyboardType ?? TextInputType.text,
                onChanged: (value) {
                  fieldState.didChange(value); // Actualiza el estado del campo
                },
                style: AppTextStyle.normal,
                decoration: InputDecoration(
                  hintText: hintText ?? '',
                  hintStyle: AppTextStyle.normalGrey,
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                ),
              ),
            ),
            if (errorText != null)
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 12),
                child: Text(
                  errorText,
                  style: const TextStyle(color: Colors.red, fontSize: 13),
                ),
              ),
          ],
        );
      },
    );
  }
}