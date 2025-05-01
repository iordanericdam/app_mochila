import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final VoidCallback? onTap;

  const UserAvatar({
    super.key,
    this.imageUrl,
    this.size = 40,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const defaultAsset = 'assets/images/default_home_images/avatar_default.jpeg';
   return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: size / 1.3,
        backgroundColor: Colors.white.withValues(alpha: 0.3),
        backgroundImage: const AssetImage(defaultAsset),
      ),
    );
  }
}