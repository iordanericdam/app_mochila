import 'package:flutter/material.dart';
import 'package:app_mochila/styles/app_text_style.dart';
import 'package:app_mochila/presentation/widgets/custom_switch.dart';

class SwitchWithTitle extends StatelessWidget {
  final String titulo;
  final String activeText;
  final String inactiveText;
  final bool isActive;
  final Function(bool) onChanged;

  const SwitchWithTitle({
    super.key,
    required this.titulo,
    required this.activeText,
    required this.inactiveText,
    required this.isActive,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // "Columna" del título
          SizedBox(
            width: 150, // Ajusta la separación del toogle y el texto
            child: Text(
              titulo,
              style: AppTextStyle.title,
            ),
          ),
         
          CustomSwitch(
            activeText: activeText,
            inactiveText: inactiveText,
            isActive: isActive,
            onChanged: onChanged,
          ),
        ],
      
    );
  }
}