import 'package:app_mochila/models/Trip.dart';
import 'package:app_mochila/providers/trip_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// Tips:
// En la pagina de trip_list_screen, extends ConsumerWidget
// En la pagina de editar/crear, extends ConsumerStatefulWidget
// ¿Cuándo usar ConsumerStatefulWidget?
//   Si tu componente:
//   Necesita un formulario (Form)
// Usa estado local, como TextEditingController, un selector de fecha, un interruptor, etc.
// debes usar ConsumerStatefulWidget.
// Porque ConsumerWidget es stateless, y no permite usar estado local ni setState.
// Por eso, si usas formularios, controladores o fechas, no puedes usar ConsumerWidget.
class EditTripScreen extends ConsumerStatefulWidget {
  // Acepta el parametro Trip
  final Trip trip;

  const EditTripScreen({super.key, required this.trip});

  @override
  ConsumerState<EditTripScreen> createState() => _EditTripScreenState();
}

class _EditTripScreenState extends ConsumerState<EditTripScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _destinationController = TextEditingController();
  final _temperatureController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    // Inicialización de los datos del formulario
    _nameController.text = widget.trip.name;
    _destinationController.text = widget.trip.destination;
    _temperatureController.text = widget.trip.temperature;
    _startDate = widget.trip.startDate;
    _endDate = widget.trip.endDate;
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate() ||
        _startDate == null ||
        _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor, completa todos los campos")),
      );
      return;
    }

    final updatedTrip = Trip(
      id: widget.trip.id,
      name: _nameController.text,
      destination: _destinationController.text,
      temperature: _temperatureController.text,
      startDate: _startDate!,
      endDate: _endDate!,
      description: "Nico", // Puedes reemplazarlo por un campo si lo prefieres
    );

    final tripData = {
      'name': updatedTrip.name,
      'destination': updatedTrip.destination,
      'temperature': updatedTrip.temperature,
      'start_date': DateFormat('yyyy-MM-dd').format(updatedTrip.startDate),
      'end_date': DateFormat('yyyy-MM-dd').format(updatedTrip.endDate),
      'description': updatedTrip.description,
    };

    // El metodo: Future<Trip> updateTrip(int tripId, Map<String, dynamic> updateData) => Llamar la api para actualizar trip y cambiar el state, La pagina se dibuja otra vez
    // El parametro:Map<String, dynamic> updateData, es un dato de json como {"name" : "My trip", "start_date": '2025-12-05'}
    await ref
        .read(tripNotifierProvider.notifier)
        .updateTrip(widget.trip.id!, tripData);

// Esto asegura que el contexto todavía está montado en el árbol de widgets, es decir, que la pantalla sigue activa.
// A veces, después de una operación async, el usuario puede haber salido de la pantalla.
// Si haces Navigator.pop(context) sin verificar, puede dar error.
// Por eso usamos if (context.mounted), para evitar errores si el widget ya fue eliminado.
// Es una buena práctica al usar navegación después de tareas asincrónicas.
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Editar Viaje")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration:
                    const InputDecoration(labelText: "Nombre del viaje"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Requerido" : null,
              ),
              TextFormField(
                controller: _destinationController,
                decoration: const InputDecoration(labelText: "Destino"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Requerido" : null,
              ),
              TextFormField(
                controller: _temperatureController,
                decoration: const InputDecoration(labelText: "Temperatura"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Requerido" : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(_startDate == null
                        ? "Fecha inicio no elegida"
                        : "Inicio: ${_startDate!.day}/${_startDate!.month}/${_startDate!.year}"),
                  ),
                  ElevatedButton(
                    onPressed: () => _pickDate(context, true),
                    child: const Text("Elegir inicio"),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(_endDate == null
                        ? "Fecha fin no elegida"
                        : "Fin: ${_endDate!.day}/${_endDate!.month}/${_endDate!.year}"),
                  ),
                  ElevatedButton(
                    onPressed: () => _pickDate(context, false),
                    child: const Text("Elegir fin"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _submitForm,
                icon: const Icon(Icons.save),
                label: const Text("Guardar cambios"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickDate(BuildContext context, bool isStartDate) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365 * 5)),
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }
}
