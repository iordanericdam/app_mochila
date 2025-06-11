import 'package:app_mochila/presentation/widgets/widgetTrips/custom_input_trip_tittle.dart';
import 'package:app_mochila/services/form_validator.dart';
import 'package:counter/r.dart';
import 'package:flutter/material.dart';
import 'package:app_mochila/models/Item.dart';
import 'package:counter/counter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_mochila/providers/item_notifier.dart';

class CategoryCard extends ConsumerWidget {
  final String title;
  final int categoryId;
  final int backpackId;

  const CategoryCard({
    super.key,
    required this.title,
    required this.categoryId,
    required this.backpackId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(itemNotifierProvider(backpackId));

    return itemsAsync.when(
      data: (allItems) {
        final items =
            allItems.where((i) => i.category_id == categoryId).toList();

        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    IconButton(
                      icon: const Icon(Icons.add, color: Colors.blue),
                      onPressed: () => _openItemDialog(context, ref),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ...items.map(
                  (item) => ListTile(
                    key: ValueKey(item.id),
                    leading: Checkbox(
                      value: item.isChecked,
                      onChanged: (_) {
                        ref
                            .read(itemNotifierProvider(backpackId).notifier)
                            .toggleChecked(item);
                      },
                    ),
                    title: Text(
                      item.quantity > 1
                          ? '${item.name} (x${item.quantity})'
                          : item.name,
                    ),
                    onTap: () {
                      ref
                          .read(itemNotifierProvider(backpackId).notifier)
                          .toggleChecked(item);
                    },
                    onLongPress: () {
                      _openItemDialog(context, ref, itemToEdit: item);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => Text('Error: $e'),
    );
  }

  void _openItemDialog(BuildContext context, WidgetRef ref,
      {Item? itemToEdit}) {
    final nameController =
        TextEditingController(text: itemToEdit != null ? itemToEdit.name : '');
    num counterValue = itemToEdit?.quantity ?? 1;

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(itemToEdit != null ? 'Editar ítem' : 'Añadir ítem'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomInputTripTitle(
                hintText: "Nombre",
                controller: nameController,
                keyboardType: TextInputType.text,
                validator: (value) => genericValidator(value, 3),
              ),
              const SizedBox(height: 16),
              const Text("Cantidad"),
              Counter(
                min: 1,
                max: 99,
                initial: counterValue,
                step: 1,
                configuration: DefaultConfiguration(),
                onValueChanged: (value) => counterValue = value,
              ),
            ],
          ),
          actions: [
            if (itemToEdit != null)
              TextButton(
                onPressed: () {
                  ref
                      .read(itemNotifierProvider(backpackId).notifier)
                      .deleteItem(itemToEdit.id);
                  Navigator.pop(context);
                },
                child:
                    const Text('Eliminar', style: TextStyle(color: Colors.red)),
              ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text;
                final quantity = counterValue.toInt();

                if (name.isEmpty || quantity < 1) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Rellena el nombre y cantidad válida')),
                  );
                  return;
                }

                final provider =
                    ref.read(itemNotifierProvider(backpackId).notifier);

                if (itemToEdit != null) {
                  provider.updateItem(itemToEdit.copyWith(
                    name: name,
                    quantity: quantity,
                  ));
                } else {
                  provider.addItem(Item(
                    name: name,
                    quantity: quantity,
                    isChecked: false,
                    category_id: categoryId,
                    categoryName: title,
                  ));
                }

                Navigator.pop(context);
              },
              child: Text(itemToEdit != null ? 'Actualizar' : 'Añadir'),
            ),
          ],
        );
      },
    );
  }
}
