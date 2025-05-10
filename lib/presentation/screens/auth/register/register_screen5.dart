import 'dart:io';

import 'package:app_mochila/presentation/widgets/button_login.dart';
import 'package:app_mochila/presentation/widgets/white_base_container.dart';
import 'package:app_mochila/providers/user_notifier.dart';
import 'package:app_mochila/styles/app_colors.dart';
import 'package:app_mochila/styles/app_text_style.dart';
import 'package:app_mochila/styles/base_scaffold.dart';
import 'package:app_mochila/styles/constants.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen5 extends ConsumerStatefulWidget {
  final String email;
  final String password;
  final String usuario;
  final String nombre;
  final String telefono;

  const RegisterScreen5({
    super.key,
    required this.email,
    required this.password,
    required this.usuario,
    required this.nombre,
    required this.telefono,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegisterScreen5State();
}

class _RegisterScreen5State extends ConsumerState<RegisterScreen5> {
  File? _pickedImage;
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        body: WhiteBaseContainer(
            child: Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              kDoubleSizedBox,
              kDoubleSizedBox,
              SizedBox(),
              const Text(
                "Sube tu mejor foto",
                style: AppTextStyle.heroTitle,
              ),
              sizedBox,
              kDoubleSizedBox,
              GestureDetector(
                onTap: _pickImage,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    width: 200,
                    height: 200,
                    child: _pickedImage != null
                        ? Image.file(
                            _pickedImage!,
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/placeholder.jpg',
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              kHalfSizedBox,
              kDoubleSizedBox,
              kDoubleSizedBox,
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CustomButtonLogin(
                  text: 'Finalizar',
                  gradient: AppColors.loginButtonColor,
                  onPressed: () async {
                    await ref
                        .read(userNotifierProvider.notifier)
                        .registerWithPhoto({
                      "email": widget.email,
                      "username": widget.usuario,
                      "password": widget.password,
                      "phone": widget.telefono,
                      "name": widget.nombre,
                    }, _pickedImage);

                    Navigator.pushReplacementNamed(context, '/login');
                  },
                ),
              ),
            ],
          ),
        )
      ],
    )));
  }
}
