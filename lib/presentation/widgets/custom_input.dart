import 'package:app_mochila/styles/app_text_style.dart';
import 'package:flutter/material.dart';
import '../../styles/app_colors.dart'; // Asegúrate de importar los colores si los tienes en otro archivo

class CustomInput extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final FormFieldValidator<String>? validator;
  final String? errorText;
  final TextInputType? keyboardType;
  final Icon? icon;
  final bool obscureText;
  final Widget? suffixIcon;
  const CustomInput({
    super.key,
    this.hintText,
    this.controller,
    this.onChanged,
    this.validator,
    this.icon,
    this.obscureText = false,
    this.keyboardType,
    this.errorText,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType ?? TextInputType.text,
      forceErrorText: errorText,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hintText ?? "",
        hintStyle: AppTextStyle.normal,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
              color: AppColors.strokeInputLoginColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
              color: AppColors.strokeInputLoginColor, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide:
              const BorderSide(color: AppColors.startButtonColor, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
    );
  }
}
