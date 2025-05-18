import 'package:app_mochila/presentation/widgets/widgetsHome/user_avatar.dart';
import 'package:app_mochila/styles/app_colors.dart';
import 'package:app_mochila/styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:app_mochila/providers/user_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomHomeAppbar extends ConsumerWidget {
  const CustomHomeAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userNotifierProvider).value;
    print(user?.url_photo);
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
            child: Text(
              "WONDERBAG",
              style: AppTextStyle.heroTitleHomeWhite,
            ),
          ),

          // Botón del menú que abre el Drawer
          Align(
            alignment: Alignment.centerRight,
            child: Builder(
              builder: (context) => GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer(); // <<--- Abre el Drawer
                },
                child: const Icon(Icons.menu, color: Colors.white, size: 40),
              ),
            ),
          ),

          // Avatar a la izquierda
          Align(
            alignment: Alignment.centerLeft,
            child: UserAvatar(
              imageUrl: user?.url_photo ??
                  "assets/images/default_home_images/avatar_default.jpeg",
            ),
          ),
        ],
      ),
    );
  }
}
