import 'package:app_mochila/presentation/widgets/widgetTrips/custom_input_trip_tittle.dart';
import 'package:app_mochila/services/form_validator.dart';
import 'package:flutter/material.dart';
import 'package:app_mochila/models/Item.dart';

Widget buildCategoryCard(
  BuildContext context, {
  required String title,
  required List<Item> items,
}) {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void showAddItemDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Añadir ítem'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomInputTripTitle(
                hintText: "Nombre",
                controller: nameController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  return genericValidator(value, 3);
                },
              ),
              TextField(
                controller: quantityController,
                decoration: const InputDecoration(labelText: 'Cantidad'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                String name = nameController.text;
                String quantity = quantityController.text;
                String description = descriptionController.text;

                // TODO: añadir la lógica para guardar el nuevo ítem

                Navigator.of(context).pop();
              },
              child: const Text('Añadir'),
            ),
          ],
        );
      },
    );
  }

  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    elevation: 5,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, color: Colors.blue),
                onPressed: showAddItemDialog,
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...items.map(
            (item) => CheckboxListTile(
              title: Text(item.name),
              value: item.isChecked,
              onChanged: (val) {
                // Aquí deberías manejar el estado si usas StatefulWidget
              },
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    ),
  );
}
