import 'package:app_mochila/presentation/widgets/container_background.dart';
import 'package:app_mochila/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:app_mochila/data/weather_icon_data.dart';


class WeatherSelector extends StatefulWidget {
  final Function(String selectedWeather)? onWeatherChanged;

  const WeatherSelector({super.key, this.onWeatherChanged});

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
    return ContainerBackground(
      child: Wrap(
        spacing: 20,
        runSpacing: 16,
        children: [
          for (var weather in weatherIcons)
            GestureDetector(
              onTap: (){
                _onWeatherTap(weather.name);
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selectedWeather == weather.name
                      ? AppColors.defaultButtonColor
                      : AppColors.iconColor, // más oscuro que gris[300]
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
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
    );
  }
}