import 'package:app_mochila/providers/user_notifier.dart';
import 'package:app_mochila/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_mochila/styles/app_colors.dart';
import 'package:app_mochila/styles/app_text_style.dart';

class MenuDrawer extends ConsumerWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userNotifierProvider);
    final userName = userState.maybeWhen(
      data: (user) => user.name,
      orElse: () => 'usuario',
    );

    return Drawer(
      child: Container(
        color: Colors.white.withOpacity(0.9),
        child: Column(
          children: [
            // Cabecera
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: AppColors.backGroundLoginColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 90), // Espacio superior
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Hola, $userName',
                      style: AppTextStyle.bigBoldWhite,
                    ),
                  ),
                  sizedBox // Espacio entre el texto y el avatar
                ],
              ),
            ),
            sizedBox,
            // Opciones
            ListTile(
              leading: const Icon(Icons.settings, color: AppColors.iconColor),
              title: const Text('Ajustes', style: AppTextStyle.normal),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Funcionalidad no implementada")),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person, color: AppColors.iconColor),
              title: const Text('Cuenta', style: AppTextStyle.normal),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Funcionalidad no implementada")),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month, color: AppColors.iconColor),
              title: const Text('Calendario', style: AppTextStyle.normal),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Funcionalidad no implementada")),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.notification_important, color: AppColors.iconColor),
              title: const Text('Notificaciones', style: AppTextStyle.normal),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Funcionalidad no implementada")),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: AppColors.iconColor),
              title: const Text('Cerrar sesión', style: AppTextStyle.normal),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}