import 'package:app_mochila/data/category_name_to_id.dart';
import 'package:app_mochila/models/Backpack.dart';
import 'package:app_mochila/models/Category.dart';
import 'package:app_mochila/models/Item.dart';
import 'package:app_mochila/presentation/widgets/widgetsBackpack/backpack_card.dart';
import 'package:app_mochila/providers/item_notifier.dart';
import 'package:app_mochila/styles/app_colors.dart';
import 'package:app_mochila/styles/app_text_style.dart';
import 'package:app_mochila/styles/constants.dart';
import 'package:app_mochila/styles/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BackpackHome extends ConsumerStatefulWidget {
  const BackpackHome({super.key});

  @override
  ConsumerState<BackpackHome> createState() => _BackpackHomeState();
}

class _BackpackHomeState extends ConsumerState<BackpackHome> {
  late Backpack backpack;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    backpack = ModalRoute.of(context)!.settings.arguments as Backpack;
    // 👇 Llamamos a cargar los items cuando se monta la pantalla
    ref.read(itemNotifierProvider(backpack.id).notifier).loadItems();
  }

  @override
  Widget build(BuildContext context) {
    final String? imageUrl = backpack.urlPhoto;
    const String fallbackAsset =
        "assets/images/default_home_images/demo_mochila.jpg"; // Verificar si es una URL o un asset/imagen local
    return Scaffold(
      drawer: const MenuDrawer(), // Le decimos al Scaffold que use el Drawer
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.network(
            imageUrl!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              // Si la imagen de red falla, usar imagen local por defecto
              return Image.asset(
                fallbackAsset,
                fit: BoxFit.cover,
              );
            },
          )),
          Column(
            children: [
              // AppBar + botones
              Stack(
                children: [
                  Container(
                    height: 180,
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(30)),
                      color: Colors.transparent,
                    ),
                  ),
                  // Botón de atrás
                  Positioned(
                    top: kdefaultPadding * 2,
                    left: kdefaultPadding,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: Colors.white, size: 30),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  // Botón de menú
                  Positioned(
                    top: kdefaultPadding * 2,
                    right: kdefaultPadding,
                    child: Builder(
                      builder: (context) => IconButton(  //<-- Usamos Builder para obtener el contexto correcto
                        icon: const Icon(Icons.menu,color: Colors.white, size: 40),
                        onPressed: () {
                          Scaffold.of(context)
                              .openDrawer(); // <--- Abre el Drawer
                        },
                      ),
                    ),
                  ),
                  // Nombre de la mochila
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      color:
                          AppColors.backgroundLogoColor.withValues(alpha: 0.7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            backpack.name,
                            style: AppTextStyle.textFranja,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Lista de items
              Expanded(
                child: Consumer(
                  builder: (context, ref, _) {
                    final itemsAsync =
                        ref.watch(itemNotifierProvider(backpack.id));

                    return itemsAsync.when(
                      data: (items) {
                        print("Items: $items");
                        if (items.isEmpty) {
                          return const Center(
                            child: Text(
                              "No hay items en esta mochila",
                              style: AppTextStyle.textFranja,
                            ),
                          );
                        }
                        final List<Category> categories = [];
                        for (var item in items) {
                          final existingIndex = categories
                              .indexWhere((cat) => cat.id == item.category_id);
                          if (existingIndex != -1) {
                            categories[existingIndex].items.add(item);
                          } else {
                            categories.add(
                              Category(
                                id: item.category_id,
                                name: item.categoryName,
                                items: [item],
                              ),
                            );
                          }
                        }

                        return ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            return Column(
                              children: [
                                CategoryCard(
                                  backpackId: backpack.id,
                                  categoryId: category.id,
                                  title: category.name,
                                ),
                                sizedBox,
                              ],
                            );
                          },
                        );
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (err, _) => Center(child: Text('Error: $err')),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
