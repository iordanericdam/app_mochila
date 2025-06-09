import 'dart:io';

import 'package:app_mochila/presentation/widgets/custom_input.dart';
import 'package:app_mochila/presentation/widgets/white_base_container.dart';
import 'package:app_mochila/presentation/widgets/button_login.dart';
import 'package:app_mochila/providers/user_notifier.dart';
import 'package:app_mochila/styles/app_colors.dart';
import 'package:app_mochila/styles/app_text_style.dart';
import 'package:app_mochila/styles/base_scaffold.dart';
import 'package:app_mochila/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfilePage extends ConsumerStatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  ConsumerState<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends ConsumerState<UpdateProfilePage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  File? _selectedImage;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    final user = ref.read(userNotifierProvider).value;
    if (user != null) {
      _usernameController.text = user.name;
      _emailController.text = user.email;
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _updateProfile() async {
    setState(() {
      _loading = true;
    });

    final userData = {
      'name': _usernameController.text,
      'email': _emailController.text,
    };

    final success = await ref
        .read(userNotifierProvider.notifier)
        .updateProfile(userData, _selectedImage);

    setState(() {
      _loading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success ? 'Actualización correcta' : 'Fallo de actualización',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userNotifierProvider);

    return BaseScaffold(
      appBar: AppBar(title: const Text('Información actualizada')),
      body: WhiteBaseContainer(
        child: userState.when(
          data: (user) {
            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: kleftPadding,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Nombre completo',
                            style: AppTextStyle.title,
                          ),
                        ),
                      ),
                      kHalfSizedBox,
                      CustomInput(
                        hintText: 'Nombre',
                        controller: _usernameController,
                      ),
                      kHalfSizedBox,
                      const Padding(
                        padding: kleftPadding,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Correo',
                            style: AppTextStyle.title,
                          ),
                        ),
                      ),
                      kHalfSizedBox,
                      CustomInput(
                        hintText: 'Correo',
                        controller: _emailController,
                      ),
                      kHalfSizedBox,
                      const Padding(
                        padding: kleftPadding,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Icono',
                            style: AppTextStyle.title,
                          ),
                        ),
                      ),
                      Center(
                        child: _selectedImage != null
                            ? CircleAvatar(
                                radius: 40,
                                backgroundImage: FileImage(_selectedImage!),
                              )
                            : user.url_photo != null
                                ? CircleAvatar(
                                    radius: 40,
                                    backgroundImage:
                                        NetworkImage(user.url_photo!),
                                  )
                                : const CircleAvatar(radius: 40),
                      ),
                      Center(
                        child: TextButton.icon(
                          onPressed: _pickImage,
                          icon: const Icon(Icons.image),
                          label: const Text('Seleccionar imagen'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      kDoubleSizedBox,
                      Center(
                        child: _loading
                            ? const CircularProgressIndicator()
                            : CustomButtonLogin(
                                text: 'Actualizar',
                                gradient: AppColors.loginButtonColor,
                                onPressed: _updateProfile,
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(
            child: Text('Error al cargar la información del usuario: $e'),
          ),
        ),
      ),
    );
  }
}
