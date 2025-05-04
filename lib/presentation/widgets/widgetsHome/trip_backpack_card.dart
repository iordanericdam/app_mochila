import 'package:app_mochila/models/Backpack.dart';
import 'package:app_mochila/models/Trip.dart';
import 'package:flutter/material.dart';
import 'package:app_mochila/styles/app_text_style.dart';
import 'package:app_mochila/utils/date_utils.dart';

class TripBackpackCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final String imageUrl = trip.urlPhoto?.isNotEmpty == true
        ? trip.urlPhoto!
        : "assets/images/default_home_images/demo_mochila.jpg";
    
    final String countdownText = getCountdownText(trip.startDate);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          //darle sombra a la card 
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect( //ajusta la imagen a los bordes redondeados
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                // Imagen
                SizedBox(
                  height: 400,
                  width: double.infinity,
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                // Filtro de color
                Container(
                  height: 400,
                  width:double.infinity,
                  color: Colors.black.withValues(alpha: 0.2),
                ),
                // Título 
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                  child: Text(
                    trip.name.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: AppTextStyle.heroTitle.copyWith(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                ),
                 // Contador de días abajo centrado
                Positioned(
                  bottom: 16,
                  left: 0,
                  right: 0,
                  child: Text(
                    countdownText,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.heroTitleHomeWhite,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}