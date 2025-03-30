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

class RegisterScreen1 extends StatefulWidget {
  const RegisterScreen1({super.key});

  @override
  State<RegisterScreen1> createState() => _RegisterScreen1State();
}

class _RegisterScreen1State extends State<RegisterScreen1> {
  final nombreController = TextEditingController();
  final usuarioController = TextEditingController();
  final registerKey1 = GlobalKey<FormState>();
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
                            'Nombre',
                            textAlign: TextAlign.left,
                            style: AppTextStyle.title,
                          ),
                        ),
                        kHalfSizedBox,
                        CustomInput(
                          hintText: 'Introduce tu nombre',
                          controller: nombreController,
                          validator: (value) {
                            int length = 4;
                            return genericValidator(value, length);
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
                          validator: (value) {
                            int length = 4;
                            return genericValidator(value, length);
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
                              var nickNameDuplicated = false;
                              var response = await Register.checkNickname(
                                  nombreController.text);

                              if (response != null &&
                                  response['exists'] == true) {
                                nickNameDuplicated = true;
                              }

                              var usernameDuplicated = false;
                              response = await Register.checkUserName(
                                  usuarioController.text);
                              if (response != null &&
                                  response['exists'] == true) {
                                usernameDuplicated = true;
                              }

                              if (usernameDuplicated || nickNameDuplicated) {
                                var message1 = usernameDuplicated
                                    ? "❌ usuario ya está en uso"
                                    : '';
                                var message2 = nickNameDuplicated
                                    ? " ❌ Ese nombre de usuario ya está en uso"
                                    : '';

                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(message1 + message2)));
                                return;
                              }

                              if (registerKey1.currentState!.validate()) {
                                Navigator.pushNamed(
                                  context,
                                  '/registerPage2',
                                  arguments: {
                                    'nombre': nombreController.text,
                                    'usuario': usuarioController.text,
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
