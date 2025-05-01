import 'package:app_mochila/styles/app_colors.dart';
import 'package:app_mochila/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelector extends StatefulWidget {
  // Callback que devuelve las fechas seleccionadas al padre
  final Function(DateTime? startDate, DateTime? endDate)? onDatesChanged;

  const DateSelector({super.key, this.onDatesChanged});

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  // Variables para guardar las fechas seleccionadas
  DateTime? _fechaInicio;
  DateTime? _fechaFin;

  // Muestra el selector de fecha (showDatePicker)
  Future<void> _selectDate({required bool isInicio}) async {
    FocusScope.of(context).requestFocus(
        FocusNode()); // No entiendo por qué este funciona y este no. FocusScope.of(context).unfocus();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        // Asignamos la fecha seleccionada según si es inicio o fin
        if (isInicio) {
          _fechaInicio = picked;
        } else {
          if (_fechaInicio != null && picked.isBefore(_fechaInicio!)) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                    " La fecha fin no puede ser anterior a la fecha inicio")));
            return;
          }
          _fechaFin = picked;
        }

        // Si el widget padre necesita las fechas, se las enviamos
        if (widget.onDatesChanged != null) {
          //print("Fecha inicio $_fechaInicio");
          //print("Fecha inicio $_fechaFin");
          widget.onDatesChanged!(_fechaInicio, _fechaFin);
        }
      });
    }
  }

  // Formatear fecha  dd/MM/yyyy
  String _formatDate(DateTime? date) {
    if (date == null) return ''; // Si no hay fecha no muestra nada
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //Contenedor principal del widget
      decoration: BoxDecoration(
        color: AppColors.backGroundInputColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          insideDefaultBoxShadow(),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      child: Row(
        children: [
          //Parte izquierda
          Expanded(
            child: _buildFechaItem(
              label: 'Fecha Inicio',
              fecha: _fechaInicio,
              onTap: () => _selectDate(isInicio: true),
            ),
          ),
          // Separador
          const SizedBox(
            height: 40,
            child: VerticalDivider(
              thickness: 1,
              width: 35,
              color: Colors.grey,
            ),
          ),
          //Parte derecha
          Expanded(
            child: _buildFechaItem(
              label: 'Fecha Fin',
              fecha: _fechaFin,
              onTap: () => _selectDate(isInicio: false),
            ),
          ),
        ],
      ),
    );
  }

  // Widget que construye cada uno de los selectores de fecha (Inicio y Fin)
  Widget _buildFechaItem({
    required String label,
    required DateTime? fecha,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap, // Llama al selector de fecha al tocar
      child: Row(
        children: [
          // Icono con fondo gris redondeado
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
          const SizedBox(width: 8), // Espacio entre icono y texto
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Etiqueta para la fecha (Inicio o Fin)
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black45,
                  fontFamily: 'Montserrat',
                ),
              ),
              // Si hay una fecha seleccionada, se muestra
              if (fecha != null)
                Text(
                  _formatDate(fecha), // Muestra fecha en formato corto
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontFamily: 'Montserrat',
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}
