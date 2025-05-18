import 'package:flutter/material.dart';

class DialogUtils {
  // POPUP DIALOG FALTA IMPLENTAR
  static void mostrarDialogoNoDisponible(BuildContext context, String opcion) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Funcionalidad no disponible'),
        content: Text('La opción "$opcion" todavía no está implementada.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}

