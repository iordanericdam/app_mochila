import 'package:app_mochila/models/Trip.dart';
import 'package:app_mochila/models/User.dart';
import 'package:app_mochila/presentation/widgets/buttons.dart';
import 'package:app_mochila/presentation/widgets/floating_button.dart';
import 'package:app_mochila/presentation/widgets/widgetTrips/category_selector.dart';
import 'package:app_mochila/presentation/widgets/widgetTrips/custom_input_description.dart';
import 'package:app_mochila/presentation/widgets/widgetTrips/custom_input_trip_tittle.dart';
//import 'package:app_mochila/presentation/widgets/custom_toggle.dart';
import 'package:app_mochila/presentation/widgets/widgetTrips/switch_with_title.dart';
import 'package:app_mochila/presentation/widgets/widgetTrips/date_selector.dart';
import 'package:app_mochila/presentation/widgets/widgetTrips/weather_selector.dart';
import 'package:app_mochila/providers/trip_notifier.dart';
import 'package:app_mochila/providers/user_notifier.dart';
import 'package:app_mochila/services/api/TripApi.dart';
import 'package:app_mochila/services/form_validator.dart';

import 'package:flutter/material.dart';
import 'package:app_mochila/styles/base_scaffold.dart';
import 'package:app_mochila/styles/constants.dart';
import 'package:app_mochila/styles/app_text_style.dart';
import 'package:app_mochila/presentation/widgets/white_base_container.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TripFormScreen extends ConsumerStatefulWidget {
  const TripFormScreen({super.key});

  @override
  ConsumerState<TripFormScreen> createState() => _SetupBpTripScreenState();
}

class _SetupBpTripScreenState extends ConsumerState<TripFormScreen> {
  final _keyTripForm = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final FocusNode _titleFocus = FocusNode();
  final FocusNode _destinationFocus = FocusNode();
  DateTime? _startDate;
  DateTime? _endDate;
  List<int> _selectedCategories = [];
  bool _visibilityOn = false;
  bool _suggestionsOn = true;
  bool _showStartDateError = false;
  bool _showWeatherError = false;
  String? _selectedWeather;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  // Función auxiliar que enfoca el primer campo obligatorio vacío
  void _focusInvalidField() {
    if (_titleController.text.trim().isEmpty) {
      FocusScope.of(context).requestFocus(_titleFocus);
    } else if (_destinationController.text.trim().isEmpty) {
      FocusScope.of(context).requestFocus(_destinationFocus);
    }
  }

  // El método _submitTripForm se encarga de validar el formulario y enviar los datos al servidor, el parametro user se obtiene del provider llega desde ref.watch(userNotifierProvider)
  Future<void> _submitTripForm(User user) async {
    final isValidForm = _keyTripForm.currentState!.validate();
    final dateError = validateStartDate(_startDate) != null;
    final weatherError = validateSelectedWeather(_selectedWeather);

    // Si algo no está bien, lo marcamos y salimos
    if (!isValidForm || dateError) {
      _focusInvalidField();
      setState(() {
        _showStartDateError = dateError;
        _showWeatherError = weatherError != null;
      });
      return;
    }
    // Validar categorías seleccionadas
    if (_selectedCategories.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecciona al menos una categoría'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // Creamos el Objeto con los datos del formulario
    //print(' Categorías seleccionadas: $_selectedCategories');
    final trip = Trip(
      name: _titleController.text.trim(),
      destination: _destinationController.text.trim(),
      description: _descriptionController.text.trim(),
      startDate: _startDate!,
      endDate: _endDate ?? _startDate!,
      temperature: _selectedWeather!,
      useSuggestions: _suggestionsOn,
      categories: _selectedCategories,
    );

    debugPrint('Datos que se van a enviar al backend:');
    debugPrint(trip.toJson().toString());

    try {
      // Enviamos el formulario
      //Usamos el notifier para obtener el usuario
      debugPrint('Intentando crear viaje con: ${trip.toJson()}');
      await ref.read(tripNotifierProvider.notifier).createTrip(trip);
      debugPrint('Viaje enviado correctamente.');

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('¡Viaje creado con éxito!')),
      );

      // Limpiar el formulario y resetear estado
      setState(() {
        _keyTripForm.currentState?.reset(); // Reinicia los validadores
        _titleController.clear();
        _destinationController.clear();
        _descriptionController.clear();
        _startDate = null;
        _endDate = null;
        _selectedWeather = null;
        _selectedCategories = [];
        _visibilityOn = false;
        _suggestionsOn = true;
      });
      Navigator.pushReplacementNamed(
          context, '/home'); //Navega a la pantalla home cuando se crea el viaje
    } catch (e) {
      debugPrint('Error al crear viaje: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al crear el viaje: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(
        userNotifierProvider); // Usamos el provider para obtener el usuario y pintar la pantalla
    return userState.when(
        loading: () => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
        error: (error, stackTrace) => Scaffold(
              body: Center(child: Text('Error al cargar usuario: $error')),
            ),
        data: (user) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: BaseScaffold(
              body: Stack(
                children: [
                  // Capa 1: contenido scrollable
                  WhiteBaseContainer(
                    child: SingleChildScrollView(
                      padding: kmedium,
                      child: Form(
                        key: _keyTripForm,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sizedBox,
                            const Padding(
                              padding: kleftPadding,
                              child: Text(
                                "Título del viaje",
                                style: AppTextStyle.title,
                              ),
                            ),
                            kHalfSizedBox,
                            CustomInputTripTitle(
                              hintText: "Introduce un título...",
                              controller: _titleController,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                return genericValidator(value, 3);
                              },
                              focusNode: _titleFocus,
                            ),
                            sizedBox,

                            const Padding(
                              padding: kleftPadding,
                              child: Text(
                                "Destino",
                                style: AppTextStyle.title,
                              ),
                            ),
                            kHalfSizedBox,
                            CustomInputTripTitle(
                              hintText: "Introduce un destino...",
                              controller: _destinationController,
                              keyboardType: TextInputType.text,
                              validator: validateDestino,
                              focusNode: _destinationFocus,
                            ),
                            sizedBox,
                            DateSelector(
                              startDate: _startDate,
                              endDate: _endDate,
                              showError:
                                  _showStartDateError, // <- debe ser true cuando hay error
                              errorText: _showStartDateError
                                  ? validateStartDate(_startDate)
                                  : null,
                              onDatesChanged: (start, end) {
                                setState(() {
                                  _startDate = start;
                                  _endDate = end;
                                  _showStartDateError =
                                      false; // esto limpia el error al cambiar
                                });
                              },
                            ),
                            sizedBox,

                            Padding(
                              padding: kleftPadding,
                              child: Column(
                                children: [
                                  SwitchWithTitle(
                                    titulo: "Visibilidad",
                                    activeText: "Pública",
                                    inactiveText: "Privada",
                                    isActive: _visibilityOn,
                                    onChanged: (value) {
                                      setState(() {
                                        _visibilityOn = value;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 12),
                                  SwitchWithTitle(
                                    titulo: "Sugerencias",
                                    activeText: "Activadas",
                                    inactiveText: "Desactivadas",
                                    isActive: _suggestionsOn,
                                    onChanged: (value) {
                                      setState(() {
                                        _suggestionsOn = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            sizedBox,
                            const Padding(
                              padding: kleftPadding,
                              child: Text(
                                "Descripción",
                                style: AppTextStyle.title,
                              ),
                            ),
                            kHalfSizedBox,
                            CustomInputDescription(
                              hintText: "Añade una descripción...",
                              controller: _descriptionController,
                              maxLines: 2,
                            ),
                            sizedBox,
                            const Padding(
                              padding: kleftPadding,
                              child: Text(
                                "¿Temperatura?",
                                style: AppTextStyle.title,
                              ),
                            ),
                            kHalfSizedBox,
                            Center(
                              child: WeatherSelector(
                                showError: _showWeatherError,
                                errorText:
                                    validateSelectedWeather(_selectedWeather),
                                onWeatherChanged: (weather) {
                                  setState(() {
                                    _selectedWeather = weather;
                                    _showWeatherError =
                                        false; // Borra el error al seleccionar
                                  });
                                },
                              ),
                            ),
                            sizedBox,
                            sizedBox,
                            const Padding(
                              padding: kleftPadding,
                              child: Text(
                                "Categoria",
                                style: AppTextStyle.title,
                              ),
                            ),
                            kHalfSizedBox,
                            CategorySelector(
                              onCategoriesChanged: (categories) {
                                setState(() {
                                  _selectedCategories = categories;
                                });
                              },
                            ),
                            // const SizedBox(height:80), // espacio extra para que no tape el botón
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Capa 2: botón flotante fijo abajo a la izquierda
                  Positioned(
                    bottom: 60,
                    right: 30,
                    child: FloatingButton(
                      onPressed: () =>
                          _submitTripForm(user), //Pasamos el usuario al submit
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
