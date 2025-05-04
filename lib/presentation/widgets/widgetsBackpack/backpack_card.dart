import 'package:app_mochila/presentation/widgets/widgetTrips/custom_input_trip_tittle.dart';
import 'package:app_mochila/services/form_validator.dart';
import 'package:flutter/material.dart';
import 'package:app_mochila/models/Item.dart';
import 'package:counter/counter.dart';

class CategoryCard extends StatefulWidget {
  final String title;
  final List<Item> items;

  const CategoryCard({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  CategoryCardState createState() => CategoryCardState();
}

class CategoryCardState extends State<CategoryCard> {
  final TextEditingController nameController = TextEditingController();
  num counterValue = 1; // Guardar el valor del contador

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void showAddItemDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Añadir ítem'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomInputTripTitle(
                  hintText: "Nombre",
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    return genericValidator(value, 3);
                  },
                ),
                const SizedBox(height: 16),
                const Text("Cantidad"),
                Counter(
                  min: 0,
                  max: 99,
                  initial: counterValue,
                  step: 1,
                  configuration: DefaultConfiguration(),
                  onValueChanged: (value) {
                    counterValue = value;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  nameController.text = "";
                  counterValue = 1;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                String name = nameController.text;
                num quantity = counterValue;

                print('Nombre: $name');
                print('Cantidad: $quantity');

                setState(() {
                  nameController.text = "";
                  counterValue = 1;
                });

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

  @override
  Widget build(BuildContext context) {
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
                  widget.title,
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
            ...widget.items.map(
              (item) => CheckboxListTile(
                title: Text(item.name),
                value: item.isChecked,
                onChanged: (val) {
                  // Aquí deberías manejar el estado si es necesario
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
}
