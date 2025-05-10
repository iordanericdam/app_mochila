import 'package:app_mochila/presentation/widgets/button_login.dart';

import 'package:app_mochila/presentation/widgets/password_custom_input.dart';
import 'package:app_mochila/presentation/widgets/white_base_container.dart';
import 'package:app_mochila/services/form_validator.dart';

import 'package:app_mochila/styles/app_colors.dart';
import 'package:app_mochila/styles/app_text_style.dart';
import 'package:app_mochila/styles/base_scaffold.dart';
import 'package:app_mochila/styles/constants.dart';
import 'package:flutter/material.dart';

class RegisterScreen3 extends StatefulWidget {
  const RegisterScreen3({super.key});

  @override
  State<RegisterScreen3> createState() => _RegisterScreen3State();
}

class _RegisterScreen3State extends State<RegisterScreen3> {
  final passwordController = TextEditingController();
  final confirmarPasswordController = TextEditingController();
  final registerKey3 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return BaseScaffold(
      body: WhiteBaseContainer(
        child: Form(
          key: registerKey3,
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
                          "¡Vamos Allá!",
                          style: AppTextStyle.heroTitle,
                        ),
                        sizedBox,
                        Text(
                          '¡Recuerda proteger bien tu mochila!',
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
                            'Contraseña',
                            textAlign: TextAlign.left,
                            style: AppTextStyle.title,
                          ),
                        ),
                        kHalfSizedBox,
                        PasswordInput(
                          hintText: 'Introduce tu contraseña',
                          controller: passwordController,
                          validator: (value) {
                            return validatePassword(value);
                          },
                        ),
                        sizedBox,
                        const Padding(
                          padding: kleftPadding,
                          child: Text(
                            'Confirma contraseña',
                            textAlign: TextAlign.left,
                            style: AppTextStyle.title,
                          ),
                        ),
                        kHalfSizedBox,
                        PasswordInput(
                          hintText: 'Confirma contraseña',
                          controller: confirmarPasswordController,
                          validator: (value) {
                            return validateConfirmPassword(
                                value, passwordController);
                          },
                        ),
                        sizedBox,
                        kDoubleSizedBox,
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: CustomButtonLogin(
                            text: 'Siguiente',
                            gradient: AppColors.loginButtonColor,
                            onPressed: () {
                              if (registerKey3.currentState!.validate()) {
                                Navigator.pushNamed(
                                  context,
                                  '/registerPage2',
                                  arguments: {
                                    'nombre': args['nombre'],
                                    'usuario': args['usuario'],
                                    'password': passwordController.text,
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
