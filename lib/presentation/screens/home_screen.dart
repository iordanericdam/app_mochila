import 'package:app_mochila/models/Backpack.dart';
import 'package:app_mochila/models/Trip.dart';
import 'package:app_mochila/presentation/widgets/widgetsHome/trip_backpack_card.dart';
import 'package:app_mochila/presentation/widgets/floating_button.dart';
import 'package:app_mochila/providers/trip_notifier.dart';
import 'package:app_mochila/providers/user_notifier.dart';
import 'package:app_mochila/services/backpack_service.dart'; 
import 'package:app_mochila/styles/constants.dart';
import 'package:app_mochila/styles/home_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_mochila/presentation/widgets/widgetsHome/custom_search_bar.dart';
import 'package:app_mochila/services/trip_filter_service.dart';



class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String _searchText = '';
  String _selectedFilter = 'Título';
  bool _isSearching = false; // Controla si el usuario ha empezado a escribir
  bool _showCompletedTrips = false; // Controla si se deben mostrar los viajes completados

  @override
  Widget build(BuildContext context) {
    // Escuchamos el estado del provider de viajes (puede estar cargando, con error o con datos)
    final tripsState = ref.watch(tripNotifierProvider);
    final user = ref.watch(userNotifierProvider).value;

    return HomeScaffold(
      floatingActionButton: FloatingButton(
        text: "Crear viaje",
        onPressed: () {
          // Navegamos a la pantalla de formulario
          Navigator.pushNamed(context, '/tripForm');
        },
      ),
      body: Column(
        children: [
          sizedBox,
          // Barra de búsqueda
          CustomSearchBar(
            onSearchChanged: (value) {
              setState(() {
                _searchText = value;
                _isSearching = value.isNotEmpty;
              });
            },
            onFilterChanged: (value) {
              setState(() {
                _selectedFilter = value;
                _showCompletedTrips = value == 'Completados';
              });
            },
          ),
         
          // Contenido de la pantalla
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

                // Verificamos que el usuario esté disponible
                if (user == null) {
                  return const Center(child: Text('Usuario no disponible'));
                }
                
                // Filtramos los viajes
                final filteredTrips = TripFilterService.filterTrips(
                  trips: trips,
                  searchText: _searchText,
                  selectedFilter: _selectedFilter,
                  isSearching: _isSearching,
                  showCompletedTrips: _showCompletedTrips,
                );
                
                // Usamos un FutureBuilder para esperar a que se carguen las mochilas asociadas
                return FutureBuilder<Map<int, Backpack?>>(
                  future: BackpackService.loadBackpacks(
                    trips: filteredTrips, // Solo pasamos los viajes filtrados
                    token: user.token,
                  ),
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

                    // Mostramos una lista de tarjetas, una por cada viaje filtrado
                    return ListView.builder(
                      itemCount: filteredTrips.length,
                      itemBuilder: (context, index) {
                        final trip = filteredTrips[index];
                        final backpack = backpackMap[trip.id];

                        return TripBackpackCard(
                          trip: trip,
                          backpack: backpack,
                          onTap: () {
                            if (backpack != null) {
                              debugPrint('Trip ID: ${backpack.tripId}');
                              debugPrint('Backpack ID: ${backpack.id}');

                              // FALTA LA NAVEGACION A LA PANTALLA DE MOCHILA
                              Navigator.pushNamed(context, '/backpack',
                                  arguments: backpack);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'ID viaje: ${backpack.tripId}, ID mochila: ${backpack.id}',
                                  ),
                                ),
                              );
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
    );
  }
}
