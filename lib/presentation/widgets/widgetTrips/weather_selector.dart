import 'package:app_mochila/presentation/widgets/container_background.dart';
import 'package:app_mochila/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:app_mochila/data/weather_icon_data.dart';

class WeatherSelector extends StatefulWidget {
  final Function(String selectedWeather)? onWeatherChanged;
  final bool showError;
  final String? errorText;

  const WeatherSelector({
    super.key,
    this.onWeatherChanged,
    this.showError = false,
    this.errorText,
  });

  @override
  State<WeatherSelector> createState() => _WeatherSelectorState();
}

class _WeatherSelectorState extends State<WeatherSelector> {
  String? selectedWeather;

  void _onWeatherTap(String name) {
    setState(() {
      if (selectedWeather == name) {
        selectedWeather = null; // Deselecciona si ya estaba seleccionada
      } else {
        selectedWeather = name; // Selecciona nueva
      }
    });
    widget.onWeatherChanged?.call(selectedWeather ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final bool hasError = widget.showError && (selectedWeather == null);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ContainerBackground(
              child: Wrap(
                spacing: 20,
                runSpacing: 16,
                children: [
                  for (var weather in weatherIcons)
                    GestureDetector(
                      onTap: () => _onWeatherTap(weather.name),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: selectedWeather == weather.name
                              ? AppColors.defaultButtonColor
                              : AppColors.iconColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha:0.1),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Icon(
                          weather.icon.icon,
                          size: 30,
                          color: selectedWeather == weather.name
                              ? Colors.white
                              : Colors.black54,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Borde rojo superpuesto si hay error
            if (hasError)
              Positioned.fill(
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                      border: Border.all(color: Colors.red, width: 1.5),
                    ),
                  ),
                ),
              ),
          ],
        ),
        // Espaciado antes del error con el contendor
        if (hasError && widget.errorText != null)
          const SizedBox(height: 6),
        if (hasError && widget.errorText != null) // Texto del error
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              widget.errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 13,fontFamily: 'Montserrat'),
            ),
          ),
      ],
    );
  }
}