import 'package:app_mochila/presentation/widgets/widgetTrips/custom_input_trip_tittle.dart';
import 'package:app_mochila/services/form_validator.dart';
import 'package:flutter/material.dart';
import 'package:app_mochila/models/Item.dart';
import 'package:counter/counter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_mochila/providers/item_notifier.dart';

class CategoryCard extends StatefulWidget {
  final String title;
  final List<Item> items;
  final int categoryId;
  final WidgetRef ref;

  const CategoryCard({
    super.key,
    required this.title,
    required this.items,
    required this.categoryId,
    required this.ref,
  });

  @override
  CategoryCardState createState() => CategoryCardState();
}

class CategoryCardState extends State<CategoryCard> {
  final TextEditingController nameController = TextEditingController();
  num counterValue = 1;

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void itemDialog({Item? itemToEdit}) {
    if (itemToEdit != null) {
      nameController.text = itemToEdit.name;
      counterValue = itemToEdit.quantity;
    }
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
                if (name.isEmpty || quantity < 1) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Rellena el nombre y cantidad válida')),
                  );
                  return;
                }
                if (itemToEdit != null) {
                  final updatedItem = Item(
                    id: itemToEdit.id,
                    name: name,
                    quantity: quantity.toInt(),
                    category_id: widget.categoryId,
                    isChecked: itemToEdit.isChecked, // mantiene el estado check
                  );
                  widget.ref
                      .read(itemNotifierProvider(widget.categoryId).notifier)
                      .updateItem(updatedItem);
                } else {
                  // NUEVO
                  final newItem = Item(
                    name: name,
                    quantity: quantity.toInt(),
                    category_id: widget.categoryId,
                  );

                  widget.ref
                      .read(itemNotifierProvider(widget.categoryId).notifier)
                      .addItem(newItem);
                }

                setState(() {
                  nameController.text = "";
                  counterValue = 1;
                });

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
                  onPressed: itemDialog,
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...widget.items.map(
              (item) => ListTile(
                leading: Checkbox(
                  value: item.isChecked,
                  onChanged: (val) {
                    final updatedItem = Item(
                      id: item.id,
                      name: item.name,
                      quantity: item.quantity,
                      category_id: item.category_id,
                      isChecked: val ?? false,
                    );
                    widget.ref
                        .read(itemNotifierProvider(widget.categoryId).notifier)
                        .updateItem(updatedItem);
                  },
                ),
                title: Text(
                  item.quantity > 1
                      ? '${item.name} (x${item.quantity})'
                      : item.name,
                ),
                contentPadding: EdgeInsets.zero,
                onLongPress: () {
                  itemDialog(itemToEdit: item);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
