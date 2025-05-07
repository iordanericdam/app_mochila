import 'package:app_mochila/models/Backpack.dart';
import 'package:app_mochila/models/Trip.dart';
import 'package:app_mochila/styles/app_colors.dart';
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
    final String? imageUrl = trip.urlPhoto;
    final bool isNetworkImage = imageUrl != null && imageUrl.startsWith('http'); // Verificar si es una URL o un asset/imagen local
    const String fallbackAsset = "assets/images/default_home_images/demo_mochila.jpg"; // respaldo imagen local por defecto
    final String countdownText = getCountdownText(trip.startDate, trip.endDate); // Texto con el contador de días

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          // darle sombra a la card 
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(128), // equivale a alpha: 0.5
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect( // ajusta la imagen a los bordes redondeados
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                // Imagen (desde red o local según corresponda)
                SizedBox(
                  height: 400,
                  width: double.infinity,
                  child: isNetworkImage
                      ? Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            // Si la imagen de red falla, usar imagen local por defecto
                            return Image.asset(
                              fallbackAsset,
                              fit: BoxFit.cover,
                            );
                          },
                        )
                      : Image.asset(
                          fallbackAsset,
                          fit: BoxFit.cover,
                        ),
                ),
                // Filtro de color
                Container(
                  height: 400,
                  width: double.infinity,
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
                // Franja de abajo
                Positioned(
                  bottom: 16,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    color: AppColors.backgroundLogoColor.withOpacity(0.7), 
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          countdownText,
                          style: AppTextStyle.textFranja,
                        ),
                      ],
                    ),
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