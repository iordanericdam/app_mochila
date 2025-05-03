// import 'package:app_mochila/presentation/screens/trip/trip_create_screen.dart';
// import 'package:app_mochila/presentation/screens/trip/trip_edit_screen.dart';
// import 'package:app_mochila/providers/trip_notifier.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// // ConsumerWidget, que es un widget especial en Riverpod para escuchar cambios de estado:
// class TripsListScreen extends ConsumerWidget {
//   const TripsListScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // 1. Obtener el estado actual de los viajes desde el proveedor

//     // ----------------
//     // DETALLE:
//     // -- la relacion entre ref.watch(tripNotifierProvider) y el archivo trip_notifier.dart
//     // Cuando llamas a 'ref.watch(tripNotifierProvider)' en TripsListScreen, Riverpod activa la creación de tripNotifierProvider.
//     // Es decir, ejecuta la línea 82 en trip_notifier.dart: final tripNotifierProvider = StateNotifierProvider<TripNotifier, AsyncValue<List<Trip>>>(...)
//     // Luego, una de las variables es TripNotifier, lo que significa que ejecuta el constructor en la línea 15 en trip_notifier.dart,
//     // y dentro de este constructor se llama a loadTrips(). Finalmente, se obtienen todos los viajes del usuario.
//     // ----------------
//     final tripState = ref.watch(tripNotifierProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("My Trips"),
//       ),
//       // 2.Hay tres variables en tripsState: data, loading, error
//       // Si el estado está en 'loading', muestra un indicador de carga,
//       // Si el estado esta en 'data' , muestra la lista
//       body: tripState.when(
//         // La definición de trips se encuentra en la línea 27 de trip_notifier.dart, donde se asigna el valor:
//         // `state = AsyncData(trips);`
//         // Aquí se guarda la variable trips, cuyo valor es el resultado devuelto por la API.

//         // Si cambias el nombre de trips a lista_trips,
//         // entonces en el archivo UI trips_list_screen.dart, en la línea 25:data: (trips) => ListView.builder(...)
//         // Deberías cambiar trips por lista_trips.
//         data: (trips) => ListView.builder(
//           itemCount: trips.length,
//           itemBuilder: (context, index) {
//             final trip = trips[index];
//             return Card(
//               margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//               child: ListTile(
//                 title: Text(trip.name),
//                 subtitle: Text(
//                   '${trip.destination} | ${_formatDate(trip.startDate)} → ${_formatDate(trip.endDate)}',
//                 ),
//                 leading: const Icon(Icons.flight),
//                 // 3. Cuando se toque un viaje, puedes hacer alguna acción,
//                 // como navegar a otra pantalla o editar el viaje
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => EditTripScreen(
//                           trip:
//                               trip), // Pasa el modelo trip corresponde a la pagina de editar
//                     ),
//                   );
//                 },
//                 // Se muestra un icon para eliminar.
//                 // Cuando se toque un icon, llamar la api del eliminar su trip y actualizar el state, la pantalla se dibuja otra vez
//                 trailing: IconButton(
//                   icon: const Icon(Icons.delete),
//                   onPressed: () async {
//                     // Mostrar el cuadro de diálogo Confirmación de eliminación
//                     final confirmDelete = await showDialog<bool>(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: const Text("Confirmar eliminación"),
//                         content: const Text(
//                             "¿Estás seguro de que deseas eliminar este viaje?"),
//                         actions: [
//                           TextButton(
//                             onPressed: () => Navigator.pop(context, false),
//                             child: const Text("Cancelar"),
//                           ),
//                           TextButton(
//                             onPressed: () => Navigator.pop(context, true),
//                             child: const Text("Eliminar"),
//                           ),
//                         ],
//                       ),
//                     );

//                     if (confirmDelete == true) {
//                       // La relacion entre ref.watch(...) y ref.read(...)
//                       // ref.watch permite que la UI se suscriba a los cambios de estado, de modo que escucha automáticamente las variaciones del estado y vuelve a renderizar la pantalla.
//                       // Por otro lado, ref.read(tripApiProvider).deleteTrip(id); ejecuta un método para operar sobre los datos, pero este método tiene una línea donde se escribe:
//                       // state = AsyncData(newList);
//                       // Esto sirve para cambiar el estado. Este cambio será detectado por la UI a través de ref.watch, lo que provocará que la pantalla se vuelva a renderizar.
//                       await ref
//                           .read(tripNotifierProvider.notifier)
//                           .deleteTrip(trip.id!);
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                             content: Text("Viaje eliminado con éxito")),
//                       );
//                     }
//                   },
//                 ),
//               ),
//             );
//           },
//         ),
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (e, _) => Center(child: Text("Error: $e")),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (_) => const TripCreateScreen()),
//           );
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

//   String _formatDate(DateTime date) {
//     return "${date.day}/${date.month}/${date.year}";
//   }
// }
