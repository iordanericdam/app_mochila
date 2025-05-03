import 'package:app_mochila/presentation/widgets/widgetsHome/user_avatar.dart';
import 'package:app_mochila/styles/app_colors.dart';
import 'package:app_mochila/styles/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomHomeAppbar extends StatelessWidget {
  const CustomHomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: const BoxDecoration(
        gradient: AppColors.backGroundLoginColor,
      ),
      padding: const EdgeInsets.only(top: 50, left: 25, right: 25),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Texto centrado
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: Text(
                "APP MOCHILA",
                style: AppTextStyle.heroTitleHomeWhite, 
              ),
            ),
          ),
          // Menú a la izquierda con GestureDetector
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Menú pulsado'),
                  ),
                );
              },
              child: const Icon(Icons.menu, color: Colors.white, size: 40),
            ),
          ),
          // Avatar a la derecha
          Align(
            alignment: Alignment.centerRight,
            child: UserAvatar(
              imageUrl: "assets/images/default_home_images/avatar_default.jpeg",
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Avatar pulsado',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}