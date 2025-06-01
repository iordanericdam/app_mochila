import 'dart:io';

import 'package:app_mochila/presentation/widgets/button_login.dart';
import 'package:app_mochila/presentation/widgets/white_base_container.dart';
import 'package:app_mochila/providers/user_notifier.dart';
import 'package:app_mochila/styles/app_colors.dart';
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
  File? _selectedImage;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    final user = ref.read(userNotifierProvider).value;
    if (user != null) {
      _usernameController.text = user.name;
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
    };

    final success = await ref
        .read(userNotifierProvider.notifier)
        .updateProfile(userData, _selectedImage);

    setState(() {
      _loading = false;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Actualización correcta')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fallo de actualización')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userNotifierProvider);
// BaseScaffold(
//       body: WhiteBaseContainer(

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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(labelText: 'Nombre'),
                      ),
                      kDoubleSizedBox,
                      kDoubleSizedBox,
                      const SizedBox(height: 16),
                      _selectedImage != null
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
                      TextButton.icon(
                        onPressed: _pickImage,
                        icon: const Icon(Icons.image),
                        label: const Text('Seleccionar imagen'),
                      ),
                      const SizedBox(height: 16),
                      kDoubleSizedBox,
                      ElevatedButton(
                        onPressed: _loading ? null : _updateProfile,
                        child: _loading
                            ? const CircularProgressIndicator()
                            : const Text('Actualizar'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(
              child: Text('Error al cargar la información del usuario: $e')),
        ),
      ),
    );
  }
}
