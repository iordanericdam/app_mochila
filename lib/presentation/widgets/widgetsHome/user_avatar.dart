import 'package:app_mochila/styles/app_colors.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final VoidCallback? onTap;

  const UserAvatar({
    super.key,
    this.imageUrl,
    this.size = 50,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const defaultAvatar =
        'assets/images/default_home_images/avatar_default.jpeg';
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size, // Tamaño del contenedor exterior
        height: size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
      
        ),
        child: CircleAvatar(
          backgroundImage: imageUrl != null && imageUrl!.startsWith('http')
              ? NetworkImage(imageUrl!)
              : AssetImage(defaultAvatar),
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
