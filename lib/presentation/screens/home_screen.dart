// Importaciones necesarias: modelos, widgets personalizados, Riverpod, servicios y Flutter
import 'package:app_mochila/models/Trip.dart';
import 'package:app_mochila/models/Backpack.dart';
import 'package:app_mochila/presentation/widgets/widgetsHome/custom_home_appbar.dart';
import 'package:app_mochila/presentation/widgets/widgetsHome/trip_backpack_card.dart';
import 'package:app_mochila/presentation/widgets/floating_button.dart';
import 'package:app_mochila/providers/trip_notifier.dart';
import 'package:app_mochila/providers/user_notifier.dart';
import 'package:app_mochila/services/api/Backpackapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Pantalla principal con acceso a Riverpod usando ConsumerStatefulWidget
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Escuchamos el estado del provider de viajes (puede estar cargando, con error o con datos)
    final tripsState = ref.watch(tripNotifierProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // AppBar personalizado en la parte superior
          const CustomHomeAppbar(),
          // Contenido de la pantalla (lista de viajes)
          Expanded(
            child: tripsState.when(
              // Si está cargando, mostramos un indicador
              loading: () => const Center(child: CircularProgressIndicator()),
              // Si hay un error al cargar los viajes
              error: (err, stack) => Center(child: Text('Error: $err')),
              // Si se cargaron los viajes correctamente
              data: (trips) {
                if (trips.isEmpty) {
                  // Si no hay viajes, mostramos un mensaje
                  return const Center(child: Text('No hay viajes creados'));
                }

                // Usamos un FutureBuilder para esperar a que se carguen las mochilas asociadas
                return FutureBuilder<Map<int, Backpack?>>(
                  future: _loadBackpacks(trips),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child:
                            Text('Error al cargar mochilas: ${snapshot.error}'),
                      );
                    }

                    // Si los datos están listos, accedemos al mapa de mochilas
                    final backpackMap = snapshot.data ?? {};

                    // Mostramos una lista de tarjetas, una por cada viaje
                    return ListView.builder(
                      itemCount: trips.length,
                      itemBuilder: (context, index) {
                        final trip = trips[index];
                        final backpack = backpackMap[trip.id];

                        return TripBackpackCard(
                          trip: trip,
                          backpack: backpack,
                          onTap: () {
                            if (backpack != null) {
                              debugPrint('Trip ID: ${backpack.tripId}');
                              debugPrint('Backpack ID: ${backpack.id}');
                                                                               // FALTA LA NAVEGACION A LA PANTALLA DE MOCHILA
                                                                              // Navigator.pushNamed    
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'ID viaje: ${backpack.tripId}, ID mochila: ${backpack.id}',
                                  ),
                                ),
                              );

                              // No hay Navigator.pushNamed, se queda en la misma pantalla
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Este viaje no tiene mochila asociada."),
                                ),
                              );
                            }
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      // Botón flotante para crear nuevo viaje
      floatingActionButton: FloatingButton(
        text: "Crear viaje",
        onPressed: () {
          // Navegamos a la pantalla de formulario
          Navigator.pushNamed(context, '/tripForm');
        },
      ),
    );
  }

  // Función para obtener la primera mochila asociada a cada viaje del usuario
  Future<Map<int, Backpack?>> _loadBackpacks(List<Trip> trips) async {
    // Obtenemos el usuario actual desde el provider
    final user = ref.read(userNotifierProvider).value;

    if (user == null) {
      debugPrint("ERROR: Usuario no cargado");
      throw Exception("User not loaded");
    }

    // Instanciamos la API de mochilas con el token del usuario
    final backpackApi = Backpackapi(token: user.token);
    Map<int, Backpack?> map = {};

    // Recorremos todos los viajes y buscamos su primera mochila asociada
    for (var trip in trips) {
      if (trip.id == null) continue;
      final tripBackpacks = await backpackApi.getBackpacksByTrip(trip.id!);
      debugPrint("Respuesta de API para Trip ID ${trip.id}: $tripBackpacks");
      map[trip.id!] = tripBackpacks.isNotEmpty ? tripBackpacks.first : null;
    }

    return map;
  }
}
