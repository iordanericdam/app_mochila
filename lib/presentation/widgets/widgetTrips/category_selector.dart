//import 'package:app_mochila/styles/app_colors.dart';
import 'package:app_mochila/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:app_mochila/styles/app_text_style.dart';
import 'package:app_mochila/data/category_data.dart';

class CategorySelector extends StatefulWidget {
  // Callback que se ejecuta cuando se selecciona una categoría
  final Function(List<String> selectedCategories)? onCategoriesChanged;

  const CategorySelector({super.key, this.onCategoriesChanged});

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  // Guarda la lista de IDs de categorías seleccionadas
  List<String> selectedCategoryIds = [];

  // Se ejecuta al hacer tap sobre una categoría
  void _categoryTaps(int id) {
    final idStr = id.toString();
    setState(() {
      if (selectedCategoryIds.contains(idStr)) {
        selectedCategoryIds.remove(idStr); // Si ya está seleccionada, la deselecciona
      } else {
        selectedCategoryIds.add(idStr); // Si no está seleccionada, la selecciona
      }
    });

    //print("Categorías: $selectedCategoryIds");
    widget.onCategoriesChanged?.call(selectedCategoryIds);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20, // Espacio horizontal entre tarjetas
      runSpacing: 16, // Espacio vertical entre tarjetas
      children: [
        // CARDS
        for (var category in categories)
          GestureDetector(
            onTap: () => _categoryTaps(category.id), // Usamos el ID real
            child: Stack(
              children: [
                // Imagen de fondo
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [defaultBoxShadow()],
                  ),
                  clipBehavior: Clip.hardEdge, // Corta la imagen para que no sobresalga de las esquinas redondeadas
                  child: Image.asset(
                    category.imageUrl,
                    fit: BoxFit.cover,
                    width: 150,
                    height: 150,
                  ),
                ),

                // Oscurecer la imagen si está seleccionada
                if (selectedCategoryIds.contains(category.id.toString()))
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color.fromARGB(0, 151, 151, 151).withAlpha(180),
                    ),
                  ),

                // Etiqueta inferior con el nombre
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(130),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Text(
                      category.name,
                      style: AppTextStyle.normalBoldWhite,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),

        // TARJETA PARA AÑADIR NUEVA CATEGORÍA (desactivada por ahora)
        // GestureDetector(
        //   onTap: () {
        //     // FALTA AÑADIR EL MODAL 
        //   },
        //   child: Container(
        //     width: 150,
        //     height: 150,
        //     decoration: BoxDecoration(
        //       color: AppColors.backGroundInputColor, 
        //       borderRadius: BorderRadius.circular(16),
        //       boxShadow: [
        //         defaultBoxShadow()
        //       ],
        //     ),
        //     child: const Icon(
        //       Icons.add, 
        //       size: 70,
        //       color: Colors.black54,
        //     ),
        //   ),
        // )
      ],
    );
  }
}