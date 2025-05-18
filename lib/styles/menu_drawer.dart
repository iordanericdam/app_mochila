import 'package:app_mochila/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_mochila/styles/app_colors.dart';
import 'package:app_mochila/styles/app_text_style.dart';
import 'package:app_mochila/styles/constants.dart';
import 'package:app_mochila/providers/user_notifier.dart';
import 'package:app_mochila/presentation/widgets/widgetsHome/user_avatar.dart';

class MenuDrawer extends ConsumerWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userNotifierProvider);
    final userName = userState.value!.name;
    return Drawer(
      backgroundColor: const Color.fromARGB(232, 54, 53, 53),
      child: Column(
        children: [
          // Cabecera
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            decoration: const BoxDecoration(
              gradient: AppColors.backGroundLoginColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 70.0), //parte superior de la pantalla
              child: Row(
                children: [
                  // const UserAvatar(size: 60),
                  UserAvatar(
                    imageUrl: userState.value!.url_photo ??
                        "assets/images/default_home_images/avatar_default.jpeg",
                  ),
                  const SizedBox(
                      width: 30), //separacion entre el avatar y el texto
                  Expanded(
                    child: Text(
                      'Hola $userName',
                      style: AppTextStyle.heroTitleHomeWhite,
                    ),
                  ),
                ],
              ),
            ),
          ),
          sizedBox,
          // Menú
          Expanded(
            child: Column(
              children: [
                ListTile(
                  leading:
                      const Icon(Icons.settings, color: Colors.white, size: 35),
                  title: const Text('Ajustes',
                      style: AppTextStyle.heroTitleHomeWhite),
                  onTap: () => DialogUtils.mostrarDialogoNoDisponible(context, 'Ajustes'),
                ),
                sizedBox,
                ListTile(
                  leading:
                      const Icon(Icons.person, color: Colors.white, size: 35),
                  title: const Text('Cuenta',
                      style: AppTextStyle.heroTitleHomeWhite),
                  onTap: () => DialogUtils.mostrarDialogoNoDisponible(context, 'Cuenta'),
                ),
                sizedBox,
                ListTile(
                  leading: const Icon(Icons.calendar_today,
                      color: Colors.white, size: 35),
                  title: const Text('Calendario',
                      style: AppTextStyle.heroTitleHomeWhite),
                  onTap: () => DialogUtils.mostrarDialogoNoDisponible(context, 'Calendario'),
                ),
                sizedBox,
                ListTile(
                  leading: const Icon(Icons.notifications,
                      color: Colors.white, size: 35),
                  title: const Text('Notificaciones',
                      style: AppTextStyle.heroTitleHomeWhite),
                 onTap: () => DialogUtils.mostrarDialogoNoDisponible(context, 'Notificaciones'),
                ),
              ],
            ),
          ),

          // Cerrar sesión abajo del todo
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 40),
            child: ListTile(
              leading: const Icon(Icons.power_settings_new,
                  color: Colors.white, size: 35),
              title: const Text('Cerrar sesión',
                  style: AppTextStyle.heroTitleHomeWhite),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ),
        ],
      ),
    );
  }
}
