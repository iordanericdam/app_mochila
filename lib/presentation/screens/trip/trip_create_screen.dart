import 'package:app_mochila/providers/trip_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_mochila/models/Trip.dart';

class TripCreateScreen extends ConsumerStatefulWidget {
  const TripCreateScreen({super.key});

  @override
  ConsumerState<TripCreateScreen> createState() => _TripCreateScreenState();
}

class _TripCreateScreenState extends ConsumerState<TripCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _destinationController = TextEditingController();
  final _temperatureController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

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

  void _submitForm() async {
    if (!_formKey.currentState!.validate() ||
        _startDate == null ||
        _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor, completa todos los campos")),
      );
      return;
    }

    final trip = Trip(
      name: _nameController.text,
      destination: _destinationController.text,
      temperature: _temperatureController.text,
      startDate: _startDate!,
      endDate: _endDate!,
      description: _descriptionController.text,
    );

    await ref.read(tripNotifierProvider.notifier).createTrip(trip);
    if (context.mounted) {
      Navigator.pop(context); // volver a la lista
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Crear Viaje")),
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
                controller: _descriptionController, // Adding description field
                decoration: const InputDecoration(labelText: "Descripción"),
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
                label: const Text("Crear viaje"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
