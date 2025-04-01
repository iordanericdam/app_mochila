import 'dart:async';

import 'package:app_mochila/presentation/widgets/button_login.dart';
import 'package:app_mochila/presentation/widgets/custom_input.dart';
import 'package:app_mochila/presentation/widgets/white_base_container.dart';
import 'package:app_mochila/services/api_service.dart';
import 'package:app_mochila/services/form_validator.dart';
import 'package:app_mochila/services/register.dart';
import 'package:app_mochila/styles/app_colors.dart';
import 'package:app_mochila/styles/app_text_style.dart';
import 'package:app_mochila/styles/base_scaffold.dart';
import 'package:app_mochila/styles/constants.dart';
import 'package:flutter/material.dart';

class RegisterScreen2 extends StatefulWidget {
  const RegisterScreen2({super.key});

  @override
  State<RegisterScreen2> createState() => _RegisterScreen2State();
}

class _RegisterScreen2State extends State<RegisterScreen2> {
  final emailController = TextEditingController();
  final telefonoController = TextEditingController();
  final registerKey2 = GlobalKey<FormState>();
  bool _emailExiste = false;
  Timer? _debounce;

  void _verificarUsuario(String mail) async {
    var response = await ApiService.checkEmail(mail);
    if (response != null && response['exists'] == true) {
      setState(() {
        _emailExiste = true;
      });
    } else {
      setState(() {
        _emailExiste = false;
      });
    }
  }

  // Utilizo dos metodos para evitar muchas llamadas a la Api, agrego un debounce para separar las llamadas a la API
  void _onEmailChange(String username) {
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
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    return BaseScaffold(
      body: WhiteBaseContainer(
        child: Form(
          key: registerKey2,
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
                          "¡Ya casi está listo!",
                          style: AppTextStyle.heroTitle,
                        ),
                        sizedBox,
                        Text(
                          '¡Ves pesando en tu mochila!',
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
                            'Email',
                            textAlign: TextAlign.left,
                            style: AppTextStyle.title,
                          ),
                        ),
                        kHalfSizedBox,
                        CustomInput(
                          hintText: 'Introduce tu email',
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          onChanged: _onEmailChange,
                          validator: (value) {
                            return emailValidator(value);
                          },
                          errorText: _emailExiste
                              ? 'Este email ya se encentra registrado'
                              : null,
                        ),
                        sizedBox,
                        const Padding(
                          padding: kleftPadding,
                          child: Text(
                            'Teléfono (Opcional)',
                            textAlign: TextAlign.left,
                            style: AppTextStyle.title,
                          ),
                        ),
                        kHalfSizedBox,
                        CustomInput(
                          hintText: 'Introduce tu teléfono',
                          controller: telefonoController,
                          validator: (value) {
                            int length = 9;
                            return telefonoValidator(value, length);
                          },
                        ),
                        sizedBox,
                        kDoubleSizedBox,
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: CustomButtonLogin(
                            text: 'Siguiente',
                            gradient: AppColors.loginButtonColor,
                            onPressed: () async {
                              if (registerKey2.currentState!.validate()) {
                                Navigator.pushNamed(
                                  context,
                                  '/registerPage3',
                                  arguments: {
                                    'nombre': args['nombre'],
                                    'usuario': args['usuario'],
                                    'email': emailController.text,
                                    'telefono': telefonoController.text
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
