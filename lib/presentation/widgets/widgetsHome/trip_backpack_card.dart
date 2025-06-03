import 'package:app_mochila/models/Backpack.dart';
import 'package:app_mochila/models/Trip.dart';
import 'package:app_mochila/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:app_mochila/styles/app_text_style.dart';
import 'package:app_mochila/utils/date_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_mochila/providers/trip_notifier.dart';

class TripBackpackCard extends ConsumerWidget {
  final Trip trip;
  final Backpack? backpack;
  final VoidCallback onTap;

  const TripBackpackCard({
    super.key,
    required this.trip,
    required this.backpack,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? imageUrl = trip.urlPhoto;
    final bool isNetworkImage = imageUrl != null && imageUrl.startsWith('http'); // Verificar si es una URL o un asset/imagen local
    const String fallbackAsset = "assets/images/default_home_images/demo_mochila.jpg"; // respaldo imagen local por defecto
    final String countdownText = getCountdownText( trip.startDate, trip.endDate); // Texto con el contador de días

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
      child: GestureDetector(
        onTap: onTap,
        onLongPress: () => showOptionsTrip(context,
            ref), // Si se mantiene presionada la card abre el diálogo de opciones
        child: Container(
          // darle sombra a la card
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(128),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            // ajusta la imagen a los bordes redondeados
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                // Imagen
                SizedBox(
                  height: 400,
                  width: double.infinity,
                  child: isNetworkImage
                      ? Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            // Si la imagen de red falla, usar imagen local por defecto
                            return Image.asset(
                              fallbackAsset,
                              fit: BoxFit.cover,
                            );
                          },
                        )
                      : Image.asset(
                          fallbackAsset,
                          fit: BoxFit.cover,
                        ),
                ),
                // Filtro de color
                Container(
                  height: 400,
                  width: double.infinity,
                  color: Colors.black.withValues(alpha: 0.2),
                ),
                // Título
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 24.0, horizontal: 16.0),
                  child: Text(
                    trip.name.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: AppTextStyle.heroTitle.copyWith(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                ),
                // Franja de abajo
                Positioned(
                  bottom: 16,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    color: AppColors.backgroundLogoColor.withValues(alpha: 0.7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          countdownText,
                          style: AppTextStyle.textFranja,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  // Metodo para mostrar las opciones del viaje
  void showOptionsTrip(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Opciones del viaje'),
        content: const Text('¿Qué quieres hacer?'),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          // Botón EDITAR
          TextButton.icon(
            icon: const Icon(Icons.edit),
            label: const Text('Editar'),
            onPressed: () {
              Navigator.pop(context); // cierra este diálogo
              _openEditDialog(context, ref); // abre el editor de título
            },
          ),
          // Botón ELIMINAR
          TextButton.icon(
            icon: const Icon(Icons.delete, color: Colors.red),
            label: const Text('Eliminar', style: TextStyle(color: Colors.red)),
            onPressed: () {
              Navigator.pop(context); // cierra este diálogo
              _confirmDelete(context, ref); // pide confirmación
            },
          ),
        ],
      ),
    );
  }
  //Metodo para editar el viaje, abre un dialogo
  void _openEditDialog(BuildContext context, WidgetRef ref) {
    final TextEditingController controller = TextEditingController(text: trip.name); // Innicializamos el controlador con el nombre actual del viaje
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar título'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Nuevo título'),
        ),
        actionsAlignment: MainAxisAlignment
            .spaceBetween, // Alineamos los botones a los extremos
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              final newTitle = controller.text.trim();
              if (newTitle.isNotEmpty) {
                ref.read(tripNotifierProvider.notifier) .updateTrip(trip.id!, {"name": newTitle}); // Notificamos al provider y actualizamos el viaje
              }
              Navigator.pop(context); // Cerramos el diálogo
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }
  // Metodo para borrar el viaje, abre un dialogo boolean
  void _confirmDelete(BuildContext context, WidgetRef ref) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Estás seguro?'),
        content: const Text('Borrarás tu viaje permanentemente.'),
        actionsAlignment: MainAxisAlignment
            .spaceBetween, // Alineamos los botones a los extremos
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child:
                const Text('Eliminar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (ok == true) {
      ref.read(tripNotifierProvider.notifier).deleteTrip(trip.id!); // Notificamos al provider y eliminamos el viaje
    }
  }

  // // Método para abrir el diálogo de opciones del viaje
  //   void _showOptionsTrip(BuildContext context, WidgetRef ref) {
  //   showModalBottomSheet(
  //     context: context,
  //     backgroundColor: Colors.white,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  //     ),
  //     builder: (_) {
  //       return SafeArea(
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             // Botón Editar
  //             ListTile(
  //               leading: const Icon(Icons.edit),
  //               title: const Text('Editar título'),
  //               onTap: () {
  //                 Navigator.pop(context); // cierra el sheet
  //                 _openEditDialog(context, ref); // abre diálogo de edición
  //               },
  //             ),
  //             // Botón Eliminar
  //             ListTile(
  //               leading: const Icon(Icons.delete, color: Colors.red),
  //               title:
  //                   const Text('Eliminar', style: TextStyle(color: Colors.red)),
  //               onTap: () {
  //                 Navigator.pop(context); // cierra el sheet
  //                 _confirmDelete(context, ref); // confirma eliminación
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  // void _openEditDialog(BuildContext context, WidgetRef ref) {
  //   final TextEditingController controller =
  //       TextEditingController(text: trip.name);

  //   showDialog(
  //     context: context,
  //     builder: (_) => AlertDialog(
  //       title: const Text('Editar título'),
  //       content: TextField(
  //         controller: controller,
  //         decoration: const InputDecoration(labelText: 'Nuevo título'),
  //       ),
  //       actionsAlignment: MainAxisAlignment.end,
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: const Text('Cancelar'),
  //         ),
  //         ElevatedButton(
  //           onPressed: () {
  //             final newTitle = controller.text.trim();
  //             if (newTitle.isNotEmpty) {
  //               ref
  //                   .read(tripNotifierProvider.notifier)
  //                   .updateTrip(trip.id!, {"name": newTitle});
  //             }
  //             Navigator.pop(context);
  //           },
  //           child: const Text('Guardar'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // void _confirmDelete(BuildContext context, WidgetRef ref) async {
  //   final bool? ok = await showDialog<bool>(
  //     context: context,
  //     builder: (_) => AlertDialog(
  //       title: const Text('¿Borrar viaje?'),
  //       content: const Text('Esta acción no se puede deshacer.'),
  //       actionsAlignment: MainAxisAlignment.end,
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context, false),
  //           child: const Text('Cancelar'),
  //         ),
  //         ElevatedButton(
  //           style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
  //           onPressed: () => Navigator.pop(context, true),
  //           child:
  //               const Text('Eliminar', style: TextStyle(color: Colors.white)),
  //         ),
  //       ],
  //     ),
  //   );

  //   if (ok == true) {
  //     ref.read(tripNotifierProvider.notifier).deleteTrip(trip.id!);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Viaje eliminado')),
  //     );
  //   }
  // }


}
