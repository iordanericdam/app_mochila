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
  //Guarda la lista de categorías seleccionadas
  List<String> selectedCategory = [];

  // Seejecuta al hacer tap sobre una categoroa
  void _categoryTaps(String name) {
    setState(() {
      if(selectedCategory.contains(name)) {
        selectedCategory.remove(name); // Si ya está seleccionada, la deselecciona
      } else {
        selectedCategory.add(name); // Si no está seleccionada, la selecciona
      }
    });

    widget.onCategoriesChanged?.call(selectedCategory);
  }
  // Deselecciona la categoría
  // void _deselectCategory() {
  //   if (selectedCategory != null) {
  //     setState(() {
  //       selectedCategory = null;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20, // Espacio horizontal entre tarjetas
      runSpacing: 16, // Espacio vertical entre tarjetas
      children: [
        // CARDS
        for (var category in categories)
          GestureDetector(
            onTap: () => _categoryTaps(category.name),
            child: Stack(
              children: [
                // Imagen de fondo
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow:[ defaultBoxShadow()],
                  ),
                  clipBehavior: Clip.hardEdge, //corta la imagen para que no sobresalga delas esquinas rendondeadas
                  child: Image.asset(
                    category.imageUrl,
                    fit: BoxFit.cover,
                    width: 150,
                    height: 150,
                  ),
                ),
    
                // Oscurecer la imagen si está seleccionada
                if (selectedCategory.contains(category.name))
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color.fromARGB(0, 151, 151, 151).withValues(alpha:0.7),
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
                      color: Colors.black.withValues(alpha:0.5),
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
    
        //TARJETA PARA AÑADIR NUEVA CATEGORÍA
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
        //       shadows: [
        //        // LE PONEMOS SOMBRA?
        //       ],
        //     ),
        //   ),
        // )
      ],
    );
  }
}




//VERSION UNA CATEGORIA SELECCIONADA
//class CategorySelector extends StatefulWidget {
  // Callback que se ejecuta cuando se selecciona una categoría
//   final Function(String selectedCategory)? onCategorySelected;


//   const CategorySelector({super.key, this.onCategorySelected});
  
//   @override
//   State<CategorySelector> createState() => _CategorySelectorState();
// }

//class _CategorySelectorState extends State<CategorySelector> {
  //Guarda la categoría seleccionada
  //String? selectedCategory;

  // Seejecuta al hacer tap sobre una categoroa
  // void _categoryTap(String name) {
  //   setState(() {
  //     selectedCategory = name; // Actualiza la categoría seleccionada
  //   });

  //   widget.onCategorySelected?.call(name);
  // }
  // Deselecciona la categoría
  // void _deselectCategory() {
  //   if (selectedCategory != null) {
  //     setState(() {
  //       selectedCategory = null;
  //     });
  //   }
  // }