import 'package:app_mochila/presentation/widgets/button_login.dart';
import 'package:app_mochila/presentation/widgets/custom_input.dart';
import 'package:app_mochila/presentation/widgets/white_base_container.dart';
import 'package:app_mochila/services/api_service.dart';
import 'package:app_mochila/services/form_validator.dart';
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
                          controller: emailController,
                          validator: (value) {
                            return emailValidator(value);
                          },
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
                              var response = await ApiService.checkEmail(
                                  emailController.text);
                              if (response != null &&
                                  response['exists'] == true) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("❌ El email ya está en uso")));
                                return;
                              }
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
