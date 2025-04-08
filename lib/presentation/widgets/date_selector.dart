import 'package:app_mochila/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelector extends StatefulWidget {
  final Function(DateTime? fechaInicio, DateTime? fechaFin)? onDatesChanged;

  const DateSelector({super.key, this.onDatesChanged});

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  DateTime? _fechaInicio;
  DateTime? _fechaFin;

  Future<void> _selectDate({required bool isInicio}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        if (isInicio) {
          _fechaInicio = picked;
        } else {
          _fechaFin = picked;
        }

        // Devolvemos los valores al padre si se quiere guardar en BD 
        if (widget.onDatesChanged != null) {
          widget.onDatesChanged!(_fechaInicio, _fechaFin);
        }
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('dd/MM/yyyy').format(date);
  }

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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      child: Row(
        children: [
          Expanded(
            child: _buildFechaItem(
              label: 'Fecha Inicio',
              fecha: _fechaInicio,
              onTap: () => _selectDate(isInicio: true),
            ),
          ),
          const SizedBox(
            height: 40,
             child: VerticalDivider(
              thickness: 1,
              width: 35,
              color: Colors.grey,
            ),
          ),
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

  Widget _buildFechaItem({
    required String label,
    required DateTime? fecha,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(136, 136, 135, 135),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(8),
            child: const Icon(Icons.calendar_month,
                size: 22, color: Colors.black87),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(fontSize: 14, color: Colors.black45,fontFamily: 'Montserrat')),
              if (fecha != null)
                Text(
                  _formatDate(fecha),
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontFamily: 'Montserrat'),
                ),
            ],
          )
        ],
      ),
    );
  }
}
