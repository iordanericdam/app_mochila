import 'package:app_mochila/models/Backpack.dart';
import 'package:app_mochila/models/Item.dart';
import 'package:app_mochila/presentation/widgets/widgetsBackpack/backpack_card.dart';
import 'package:app_mochila/providers/item_notifier.dart';
import 'package:app_mochila/styles/app_text_style.dart';
import 'package:app_mochila/styles/constants.dart';
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
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/category_images/mountain.jpg",
              fit: BoxFit.cover,
            ),
          ),
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
                  const Positioned(
                    top: kdefaultPadding * 2,
                    right: kdefaultPadding,
                    child: Icon(Icons.menu, color: Colors.white, size: 30),
                  ),
                  // Nombre de la mochila
                  Positioned(
                    bottom: 10,
                    left: kdefaultPadding,
                    child: Row(
                      children: [
                        Text(
                          backpack.name,
                          style: AppTextStyle.bigBoldWhite,
                        ),
                      ],
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
                        final categories = <String, List<Item>>{};
                        for (var item in items) {
                          categories
                              .putIfAbsent(item.categoryName, () => [])
                              .add(item);
                        }
                        return ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final categoryName =
                                categories.keys.elementAt(index);
                            final categoryItems = categories[categoryName]!;

                            return Column(
                              children: [
                                buildCategoryCard(
                                  context,
                                  title: categoryName,
                                  items: categoryItems,
                                ),
                                sizedBox, // Asegúrate de que esta variable esté definida
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
