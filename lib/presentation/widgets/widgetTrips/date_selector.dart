import 'package:app_mochila/styles/app_colors.dart';
import 'package:app_mochila/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelector extends StatelessWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final Function(DateTime? startDate, DateTime? endDate)? onDatesChanged;
  final bool showError;
  final String? errorText;

  const DateSelector({
    super.key,
    this.startDate,
    this.endDate,
    this.onDatesChanged,
    this.errorText,
    this.showError = false,
  });

  // Formatea la fecha a dd/MM/yyyy
  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('dd/MM/yyyy').format(date);
  }

  // Muestra el selector de fecha y actualiza las fechas seleccionadas
  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      final newStart = isStart ? picked : startDate;
      final newEnd = isStart ? endDate : picked;

      // Valida que la fecha de fin no sea anterior a la de inicio
      if (newStart != null && newEnd != null && newEnd.isBefore(newStart)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("La fecha fin no puede ser anterior a la fecha inicio"),
          ),
        );
        return;
      }

      // Notifica al widget padre que las fechas han cambiado
      onDatesChanged?.call(newStart, newEnd);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool hasError = showError && errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Stack para superponer un borde rojo si hay error, sin afectar el diseño
        Stack(
          children: [
            // Contenedor principal con estilo visual
            Container(
              decoration: BoxDecoration(
                color: AppColors.backGroundInputColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [insideDefaultBoxShadow()],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              child: Row(
                children: [
                  // Fecha de inicio
                  Expanded(
                    child: _buildFechaItem(
                      context,
                      label: 'Fecha Inicio',
                      fecha: startDate,
                      isStart: true,
                    ),
                  ),
                  // Separador vertical
                  const SizedBox(
                    height: 40,
                    child: VerticalDivider(
                      thickness: 1,
                      width: 35,
                      color: Colors.grey,
                    ),
                  ),
                  // Fecha de fin
                  Expanded(
                    child: _buildFechaItem(
                      context,
                      label: 'Fecha Fin',
                      fecha: endDate,
                      isStart: false,
                    ),
                  ),
                ],
              ),
            ),

            // borde rojo superpuesto si hay error
            if (hasError)
              Positioned.fill(
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.red, width: 1.5),
                    ),
                  ),
                ),
              ),
          ],
        ),

        // Espacio del error y el contenedor
        if (hasError)
          const SizedBox(height: 6),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              errorText!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 13,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
      ],
    );
  }

  // Construye el botón de selección de fecha con su etiqueta y valor actual
  Widget _buildFechaItem(
    BuildContext context, {
    required String label,
    required DateTime? fecha,
    required bool isStart,
  }) {
    return InkWell(
      onTap: () => _selectDate(context, isStart),
      child: Row(
        children: [
          // Icono circular
          Container(
            decoration: const BoxDecoration(
              color: AppColors.iconColor,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(8),
            child: const Icon(
              Icons.calendar_month,
              size: 22,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Etiqueta del campo
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black45,
                  fontFamily: 'Montserrat',
                ),
              ),
              // Fecha seleccionada, si la hay
              if (fecha != null)
                Text(
                  _formatDate(fecha),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontFamily: 'Montserrat',
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}