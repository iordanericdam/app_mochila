import 'package:flutter/material.dart';

class WeatherIconData {
  final String name;
  final Icon icon;

  const WeatherIconData({
    required this.name, 
    required this.icon

  });
}

 List<WeatherIconData> weatherIcons = [
  const WeatherIconData(
    name: 'Soleado',
    icon: Icon(Icons.sunny, size: 36,),
  ),
  const WeatherIconData(
    name: 'Nublado',
    icon: Icon(Icons.cloud,size: 36,),
  ),
  const WeatherIconData(
    name: 'Frío',
    icon: Icon(Icons.ac_unit, size: 36,),
  ),
   const WeatherIconData(
    name: 'Lluvia',
    icon: Icon(Icons.water_drop, size: 36,),
  ),
];