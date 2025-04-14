import 'package:flutter/material.dart';
import 'package:app_mochila/styles/app_text_style.dart';

class CustomSwitch extends StatelessWidget {
  final String activeText;
  final String inactiveText;
  final bool isActive;
  final Function(bool) onChanged;

  const CustomSwitch({
    super.key,
    required this.activeText,
    required this.inactiveText,
    required this.isActive,
    required this.onChanged,
  });

   static const WidgetStateProperty<Icon?> thumbIcon = WidgetStateProperty<Icon> //propiedad que puede devolver distintos valores (Iconos) dependiendo del estado del widget.
   .fromMap(
    <WidgetStatesConstraint, Icon>{ // Mapa que define que icono mostrar según el estado del Switch.
      WidgetState.selected: Icon(Icons.check),
      WidgetState.any: Icon(Icons.close),
    },
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Switch(
          thumbIcon: thumbIcon,
          value: isActive,
          onChanged: onChanged,
        ),
        Text(
          isActive ? activeText : inactiveText,
          style: AppTextStyle.normalGreyTitle,
        ),
      ],
    );
  }
}