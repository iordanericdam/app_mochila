import 'package:app_mochila/presentation/widgets/button_login.dart';
import 'package:app_mochila/presentation/widgets/custom_input.dart';
import 'package:app_mochila/presentation/widgets/white_base_container.dart';
import 'package:app_mochila/services/form_validator.dart';
import 'package:app_mochila/services/register.dart';
import 'package:app_mochila/styles/app_colors.dart';
import 'package:app_mochila/styles/app_text_style.dart';
import 'package:app_mochila/styles/base_scaffold.dart';
import 'package:app_mochila/styles/constants.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RegisterScreen1 extends StatefulWidget {
  const RegisterScreen1({super.key});

  @override
  State<RegisterScreen1> createState() => _RegisterScreen1State();
}

class _RegisterScreen1State extends State<RegisterScreen1> {
  final nombreController = TextEditingController();
  final usuarioController = TextEditingController();
  final registerKey1 = GlobalKey<FormState>();
  bool _usuarioExiste = false;
  File? _pickedImage;
  Timer? _debounce;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });
    }
  }

  void _verificarUsuario(String username) async {
    var response = await Register.checkUserName(username);
    if (response != null && response['exists'] == true) {
      setState(() {
        _usuarioExiste = true;
      });
    } else {
      setState(() {
        _usuarioExiste = false;
      });
    }
  }

  // Utilizo dos metodos para evitar muchas llamadas a la Api, agrego un debounce para separar las llamadas a la API
  void _onUserNameChanged(String username) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      _verificarUsuario(username);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: WhiteBaseContainer(
        child: Form(
          key: registerKey1,
          child: Padding(
            padding: klarge,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        kDoubleSizedBox,
                        SizedBox(),
                        Text(
                          "!Bienvenido!",
                          style: AppTextStyle.heroTitle,
                        ),
                        sizedBox,
                        Text(
                          'Introduce tus datos para registrarte',
                          style: AppTextStyle.normal,
                        ),
                        kDoubleSizedBox,
                        sizedBox,
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: kleftPadding,
                          child: Text(
                            'Nombre completo',
                            textAlign: TextAlign.left,
                            style: AppTextStyle.title,
                          ),
                        ),
                        kHalfSizedBox,
                        CustomInput(
                          hintText: 'Introduce tu nombre',
                          controller: nombreController,
                          validator: (value) {
                            return genericValidator(value, 4);
                          },
                        ),
                        sizedBox,
                        const Padding(
                          padding: kleftPadding,
                          child: Text(
                            'Usuario',
                            textAlign: TextAlign.left,
                            style: AppTextStyle.title,
                          ),
                        ),
                        kHalfSizedBox,
                        CustomInput(
                          hintText: 'Introduce tu usuario',
                          controller: usuarioController,
                          onChanged: _onUserNameChanged,
                          validator: (value) {
                            return genericValidator(value, 4);
                          },
                          errorText: _usuarioExiste
                              ? 'Este usuario ya se encentra registrado'
                              : null,
                        ),
                        sizedBox,
                        const Padding(
                          padding: kleftPadding,
                          child: Text(
                            'Icono del usuario',
                            textAlign: TextAlign.left,
                            style: AppTextStyle.title,
                          ),
                        ),
                        kHalfSizedBox,
                        GestureDetector(
                          onTap: _pickImage,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              width: 100,
                              height: 100,
                              child: _pickedImage != null
                                  ? Image.file(
                                      _pickedImage!,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/images/placeholder.jpg',
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                        kHalfSizedBox,
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: CustomButtonLogin(
                            text: 'Siguiente',
                            gradient: AppColors.loginButtonColor,
                            onPressed: () async {
                              if (registerKey1.currentState!.validate()) {
                                Navigator.pushNamed(
                                  context,
                                  '/registerPage2',
                                  arguments: {
                                    'nombre': nombreController.text,
                                    'usuario': usuarioController.text,
                                    'imagen': _pickedImage,
                                  },
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
